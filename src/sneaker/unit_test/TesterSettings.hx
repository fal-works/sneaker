package sneaker.unit_test;

using sneaker.format.PosInfosExtension;

import haxe.PosInfos;
import sneaker.log.LogType;
import sneaker.log.LogFormats;
import sneaker.print.Printer.println;

class TesterSettings {
	/**
		If set to `true`, the results of passed test cases are not displayed individually.

		This helps you to check only the unexpected results or the cases that should confirmed visually
		(and you can still see the aggregate results including the passed ones).

		Compilation flag:
		- If `sneaker_print_buffer_disable` is set, this variable has no effect.
	**/
	public static var hidePassedResults = false;

	/**
		If `true`, any caught exception (extending `sneaker.common.Exception`) is displayed
		with succeding call stack information.
		May not be that useful for simple test cases.
	**/
	public static var showCallStack = false;

	/**
		If `true`, any value that is caught in the `try/catch` and does not extend `sneaker.common.Exception`
		will be thrown again instead of printing it and moving on next test cases.
	**/
	public static var rethrowUnknownExceptions = false;

	/**
		Log type used in `Tester.describe()` (unless you replace the
		`TesterSettings.describe` and stop using `TesterSettings.descriptionLogType`).
		Replace or edit this type for changing the format of descriptions.
		The filters have no effect.
	**/
	public static var descriptionLogType = new LogType("[TEST]  ").setLogFormat(LogFormats.prefixMessage);

	/**
		Function used in `Tester.describe()`.
		Replaced this with any custom function to change the format.
	**/
	public static var describe = (text: String, ?pos: PosInfos) -> {
		println(StringTools.rpad(
			'TestCase____${pos.formatClassMethodWithoutModule()}',
			"_",
			100
		));
		TesterSettings.descriptionLogType.print('Description: ${text}', null, pos);
	}

	/**
		Log type used when an exception is caught during the test.
		Replace or edit this type for changing the format of that exception log.
		The filters have no effect.
	**/
	public static var exceptionLogType = new LogType("[TEST]  ").setLogFormat(LogFormats.prefixMessage);
}
