package sneaker;

using sneaker.format.PosInfosExtension;

import sneaker.log.*;

@:nullSafety(Strict)
class LogTest {
	// println
	public static final println = () -> {
		describe("This prints \"AAA\".");
		Print.println("AAA");
	};

	// logType
	public static final logType = () -> {
		describe("This prints a log message without a tag.");
		final logType = new LogType("[log line prefix]");
		logType.print("(log message)");
	};
	public static final logTypeDisabled = () -> {
		describe("This has no effect because the log type is disabled.");
		final logType = new LogType("[log line prefix]");
		logType.disablePrint();
		logType.print("(This should not be printed)");
	};
	public static final logTypeTests = runCases.bind([logType, logTypeDisabled]);

	// logType change
	public static final logTypeFilterTagTrue = () -> {
		describe("This prints a log message with a tag name.");
		final bitMask = 0x00000001;
		final logType = new LogType("[log line prefix]");
		logType.setTagBitsFilter(bitMask);
		// This is same as:
		// logType.tagFilter = (?tag:sneaker.tag.Tag) -> tag.checkNullable(bitMask);
		final tag = new sneaker.tag.Tag("(tag name)");
		tag.bits = 0x00000001;
		logType.print("(log message)", tag);
	};
	public static final logTypeFilterTagFalse = () -> {
		describe("This has no effect because the tag does not match.");
		final bitMask = 0x00001111;
		final logType = new LogType("[log line prefix]");
		logType.setTagBitsFilter(bitMask);
		// This is same as:
		// logType.tagFilter = (?tag:sneaker.tag.Tag) -> tag.checkNullable(bitMask);
		final tag = new sneaker.tag.Tag("(tag name)");
		tag.bits = 0x11110000;
		logType.print("(log message)", tag);
	};
	public static final logTypeFilterPositionTrue = () -> {
		describe("This prints a log message without a tag.");
		final logType = new LogType("[log line prefix]");
		logType.setMethodFilter("logTypeFilterPositionTrue");
		// This is same as:
		// logType.positionFilter = (?pos:haxe.PosInfos) -> pos != null && pos.methodName == "logTypeFilterPositionTrue";
		logType.print("(log message)");
	};
	public static final logTypeFilterPositionFalse = () -> {
		describe("This has no effect because the filter predicate does not match.");
		final logType = new LogType("[log line prefix]");
		logType.setMethodFilter("dummy method name");
		// This is same as:
		// logType.positionFilter = (?pos:haxe.PosInfos) -> pos != null && pos.methodName == "dummy method name";
		logType.print("(log message)");
	};
	public static final logTypeFormat = () -> {
		describe("This prints a log message in another format.");
		final logType = new LogType("[log line prefix]");
		logType.format = (prefix, message, ?tag, ?pos) -> '${prefix} ${message} // ${tag.formatNullable()} // ${pos.formatClassMethod()}';
		logType.print("(log message)");
	};
	public static final logTypeChangeTests = runCases.bind([
		logTypeFilterTagTrue,
		logTypeFilterTagFalse,
		logTypeFilterPositionTrue,
		logTypeFilterPositionFalse,
		logTypeFormat
	]);

	// log tagged
	public static final logTagged = () -> {
		describe("This prints a log message with a tag name.");
		final logType = new LogType("[log line prefix]");
		final instance = new sneaker.tag.Tagged();
		instance.tag.name = "(tag name)";
		instance.log(logType, "(log message)");
	};

	// standard logType
	public static final logTypeError = () -> {
		// -D sneaker_log_level=200
		describe("This prints a Error message.");
		sneaker.log.LogTypes.Error.print("(message)");
	};

	// log directly
	public static final directlyError = () -> {
		// -D sneaker_log_level=200
		describe("This prints an error message.");
		sneaker.log.Log.error("(message)");
	};
	public static final directlyErrorTagged = () -> {
		// -D sneaker_log_level=200
		describe("This prints a error message with a tag name.");
		final instance = new sneaker.tag.Tagged();
		instance.tag.name = "(tag name)";
		instance.error("(message)");
	};
	public static final directlyWarn = () -> {
		// -D sneaker_log_level=200
		describe("This has no effect if sneaker_log_level < 300.");
		sneaker.log.Log.warn("(message)");
	};
	public static final logdirectTests = runCases.bind([directlyError, directlyErrorTagged, directlyWarn]);

	public static final all = runCases.bind([
		println,
		logTypeTests,
		logTypeChangeTests,
		logTagged,
		logTypeError,
		logdirectTests
	]);
}
