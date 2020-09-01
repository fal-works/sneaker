package sneaker;

import sneaker.log.*;
import sneaker.print.*;

class LogTest {
	// println
	public static final println = testCase(() -> {
		#if sneaker_print_last_disable
		throw "Compiler flag sneaker_print_last_disable should not be set for these test cases.";
		#end
		describe("This prints \"AAA\".");
		Printer.println("AAA");
		if (Printer.lastBuffered != "AAA") throw "Error";
	}, Ok);

	// logType
	public static final logType = testCase(() -> {
		describe("This prints a log message without a tag.");
		final logType = new LogType("[log line prefix]");
		logType.print("(log message)");
	}, Visual);
	public static final logTypeDisabled = testCase(() -> {
		describe("This has no effect because the log type is disabled.");
		final logType = new LogType("[log line prefix]");
		logType.disablePrint();
		final lastBuffered = Printer.lastBuffered;
		logType.print("(This should not be printed)");
		if (Printer.lastBuffered != lastBuffered) throw "Error";
	}, Ok);
	public static final logTypeTests = testCaseGroup([logType, logTypeDisabled]);

	// logType change
	public static final logTypeFilterTagTrue = testCase(() -> {
		describe("This prints a log message with a tag name.");
		final bitMask = 0x00000001;
		final logType = new LogType("[log line prefix]");
		logType.setTagBitsFilter(bitMask);
		final tag: sneaker.tag.Tag = {
			name: "(tag name)",
			bits: 0x00000001
		};
		logType.print("(log message)", tag);
	}, Visual);
	public static final logTypeFilterTagFalse = testCase(() -> {
		describe("This has no effect because the tag does not match.");
		final bitMask = 0x00001111;
		final logType = new LogType("[log line prefix]");
		logType.setTagBitsFilter(bitMask);
		final tag: sneaker.tag.Tag = {
			name: "(tag name)",
			bits: 0x11110000
		};
		final lastBuffered = Printer.lastBuffered;
		logType.print("(This should not be printed)", tag);
		if (Printer.lastBuffered != lastBuffered) throw "Error";
	}, Ok);
	public static final logTypeFilterPositionTrue = testCase(() -> {
		describe("This prints a log message without a tag.");
		final logType = new LogType("[log line prefix]");
		logType.setMethodFilter("logTypeFilterPositionTrue");
		logType.print("(log message)");
	}, Visual);
	public static final logTypeFilterPositionFalse = testCase(() -> {
		describe("This has no effect because the filter predicate does not match.");
		final logType = new LogType("[log line prefix]");
		logType.setMethodFilter("dummy method name");
		final lastBuffered = Printer.lastBuffered;
		logType.print("(This should not be printed)");
		if (Printer.lastBuffered != lastBuffered) throw "Error";
	}, Ok);
	public static final logTypePositionFormat = testCase(() -> {
		describe("This prints a log message in another position format (file and line).");
		final logType = new LogType("[log line prefix]");
		logType.positionFormat = sneaker.format.PosInfosExtension.formatFileLineWithoutPath;
		logType.print("(log message)");
	}, Visual);
	public static final logTypeLogFormat = testCase(() -> {
		describe("This prints a log message in another format (only prefix and message).");
		final logType = new LogType("[log line prefix]");
		logType.logFormat = LogFormats.prefixMessage;
		logType.print("(log message)");
	}, Visual);
	public static final logTypeChangeTests = testCaseGroup([
		logTypeFilterTagTrue,
		logTypeFilterTagFalse,
		logTypeFilterPositionTrue,
		logTypeFilterPositionFalse,
		logTypePositionFormat,
		logTypeLogFormat
	]);

	// log tagged
	public static final logTagged = testCase(() -> {
		describe("This prints a log message with a tag name.");
		final logType = new LogType("[log line prefix]");
		final instance = new sneaker.tag.Tagged();
		instance.tag = new sneaker.tag.Tag("(tag name)");
		instance.log(logType, "(log message)");
	}, Visual);

	// standard logType
	public static final logTypeError = testCase(() -> {
		// -D sneaker_log_level=200
		describe("This prints an error message.");
		LogTypes.error.print("(message)");
	}, Visual);

	// log directly
	public static final directlyError = testCase(() -> {
		// -D sneaker_log_level=200
		describe("This prints an error message.");
		Logger.error("(message)");
	}, Visual);
	public static final directlyErrorTagged = testCase(() -> {
		// -D sneaker_log_level=200
		describe("This prints an error message with a tag name.");
		final instance = new sneaker.tag.Tagged();
		instance.tag = new sneaker.tag.Tag("(tag name)");
		instance.error("(message)");
	}, Visual);
	public static final directlyWarn = testCase(() -> {
		// -D sneaker_log_level=200
		describe("This has no effect if sneaker_log_level < 300.");
		final lastBuffered = Printer.lastBuffered;
		Logger.warn("(message)");
		#if (sneaker_log_level < 300)
		if (Printer.lastBuffered != lastBuffered) throw "Error";
		#else
		if (Printer.lastBuffered == lastBuffered) throw "Error";
		#end
	}, Ok);
	public static final logdirectTests = testCaseGroup([
		directlyError,
		directlyErrorTagged,
		directlyWarn
	]);

	public static final logLevel = testCase(() -> {
		// -D sneaker_log_level=200
		describe("This prints only one line: AAA");
		final logTypeA = new LogType("[prefixA]", -9999);
		var lastBuffered = Printer.lastBuffered;
		logTypeA.print("AAA");
		if (Printer.lastBuffered == lastBuffered) throw "Error";
		final logTypeB = new LogType("[prefixB]", 9999);
		lastBuffered = Printer.lastBuffered;
		logTypeB.print("BBB");
		if (Printer.lastBuffered != lastBuffered) throw "Error";
	}, Ok);

	public static final all = testCaseGroup([
		println,
		logTypeTests,
		logTypeChangeTests,
		logTagged,
		logTypeError,
		logdirectTests,
		logLevel
	]);
}
