package sneaker;

import sneaker.log.*;
import sneaker.print.*;

class LogTest {
	// println
	public static final println = testCase({
		description: "",
		run: () -> {
			describe("This prints \"AAA\".");
			Print.println("AAA");
		},
		type: Visual
	});

	// logType
	public static final logType = testCase({
		description: "",
		run: () -> {
			describe("This prints a log message without a tag.");
			final logType = new LogType("[log line prefix]");
			logType.print("(log message)");
		},
		type:Visual
	});
	public static final logTypeDisabled = testCase({
		description: "",
		run: () -> {
			describe("This has no effect because the log type is disabled.");
			final logType = new LogType("[log line prefix]");
			logType.disablePrint();
			logType.print("(This should not be printed)");
		},
		type: Visual
	});
	public static final logTypeTests = testCaseGroup([logType, logTypeDisabled]);

	// logType change
	public static final logTypeFilterTagTrue = testCase({
		description: "",
		run: () -> {
			describe("This prints a log message with a tag name.");
			final bitMask = 0x00000001;
			final logType = new LogType("[log line prefix]");
			logType.setTagBitsFilter(bitMask);
			// This is same as:
			// logType.tagFilter = (?tag:sneaker.tag.Tag) -> tag.checkNullable(bitMask);
			final tag = new sneaker.tag.Tag("(tag name)");
			tag.bits = 0x00000001;
			logType.print("(log message)", tag);
		},
		type: Visual
	});
	public static final logTypeFilterTagFalse = testCase({
		description: "",
		run: () -> {
			describe("This has no effect because the tag does not match.");
			final bitMask = 0x00001111;
			final logType = new LogType("[log line prefix]");
			logType.setTagBitsFilter(bitMask);
			// This is same as:
			// logType.tagFilter = (?tag:sneaker.tag.Tag) -> tag.checkNullable(bitMask);
			final tag = new sneaker.tag.Tag("(tag name)");
			tag.bits = 0x11110000;
			logType.print("(This should not be printed)", tag);
		},
		type: Visual
	});
	public static final logTypeFilterPositionTrue = testCase({
		description: "",
		run: () -> {
			describe("This prints a log message without a tag.");
			final logType = new LogType("[log line prefix]");
			logType.setMethodFilter("logTypeFilterPositionTrue");
			// This is same as:
			// logType.positionFilter = (?pos:haxe.PosInfos) -> pos != null && pos.methodName == "logTypeFilterPositionTrue";
			logType.print("(log message)");
		},
		type: Visual
	});
	public static final logTypeFilterPositionFalse = testCase({
		description: "",
		run: () -> {
			describe("This has no effect because the filter predicate does not match.");
			final logType = new LogType("[log line prefix]");
			logType.setMethodFilter("dummy method name");
			// This is same as:
			// logType.positionFilter = (?pos:haxe.PosInfos) -> pos != null && pos.methodName == "dummy method name";
			logType.print("(This should not be printed)");
		},
		type: Visual
	});
	public static final logTypePositionFormat = testCase({
		description: "",
		run: () -> {
			describe("This prints a log message in another position format (file and line).");
			final logType = new LogType("[log line prefix]");
			logType.positionFormat = sneaker.format.PosInfosCallbacks.formatFileLineWithoutPath;
			logType.print("(log message)");
		},
		type: Visual
	});
	public static final logTypeLogFormat = testCase({
		description: "",
		run: () -> {
			describe("This prints a log message in another format (only prefix and message).");
			final logType = new LogType("[log line prefix]");
			logType.logFormat = sneaker.log.LogFormats.prefixMessage;
			logType.print("(log message)");
		},
		type: Visual
	});
	public static final logTypeChangeTests = testCaseGroup([
		logTypeFilterTagTrue,
		logTypeFilterTagFalse,
		logTypeFilterPositionTrue,
		logTypeFilterPositionFalse,
		logTypePositionFormat,
		logTypeLogFormat
	]);

	// log tagged
	public static final logTagged = testCase({
		description: "",
		run: () -> {
			describe("This prints a log message with a tag name.");
			final logType = new LogType("[log line prefix]");
			final instance = new sneaker.tag.Tagged();
			instance.tag.name = "(tag name)";
			instance.log(logType, "(log message)");
		},
		type: Visual
	});

	// standard logType
	public static final logTypeError = testCase({
		description: "",
		run: () -> {
			// -D sneaker_log_level=200
			describe("This prints an error message.");
			sneaker.log.LogTypes.error.print("(message)");
		},
		type: Visual
	});

	// log directly
	public static final directlyError = testCase({
		description: "",
		run: () -> {
			// -D sneaker_log_level=200
			describe("This prints an error message.");
			sneaker.log.Log.error("(message)");
		},
		type: Visual
	});
	public static final directlyErrorTagged = testCase({
		description: "",
		run: () -> {
			// -D sneaker_log_level=200
			describe("This prints an error message with a tag name.");
			final instance = new sneaker.tag.Tagged();
			instance.tag.name = "(tag name)";
			instance.error("(message)");
		},
		type: Visual
	});
	public static final directlyWarn = testCase({
		description: "",
		run: () -> {
			// -D sneaker_log_level=200
			describe("This has no effect if sneaker_log_level < 300.");
			sneaker.log.Log.warn("(message)");
		},
		type: Visual
	});
	public static final logdirectTests = testCaseGroup([directlyError, directlyErrorTagged, directlyWarn]);

	public static final all = testCaseGroup([
		println,
		logTypeTests,
		logTypeChangeTests,
		logTagged,
		logTypeError,
		logdirectTests
	]);
}
