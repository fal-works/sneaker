package sneaker.tester;

using sneaker.format.PosInfosExtension;

import haxe.PosInfos;
import sneaker.log.LogType;
import sneaker.log.LogFormats;
import sneaker.log.Print.printlnString;

class Tester {
	public static var descriptionLogType = {
		final type = new LogType("[TEST]  ");
		type.logFormat = LogFormats.prefixMessage;
		type;
	}

	public static var exceptionLogType = new LogType("[TEST]  ");

	/**
	 * Prints position info and a description text.
	 * Can be used as a heading of each test case.
	 */
	public static function describe(text:String, ?pos:PosInfos):Void {
		printlnString('TestCase____${pos.formatClassMethodWithoutModule()}________________________________________________________');
		descriptionLogType.print('Description: ${text}', null, pos);
	}

	/**
	 * Run `testCase()` in `try/catch`. If anything caught, prints an ERROR log.
	 */
	public static function runCase(testCase:() -> Void):Void {
		try {
			testCase();
		} catch (exception:Dynamic) {
			exceptionLogType.print('Exception caught:\n${exception}');
		}
	}

	/**
	 * Runs each element of `testCases`, separating with a new line.
	 */
	public static function runCases(testCases:Array<() -> Void>):Void {
		final length = testCases.length;

		switch (length) {
			case 0:
				return;
			case 1:
				runCase(testCases[0]);
			default:
				runCase(testCases[0]);

				for (i in 1...length) {
					printlnString("");
					runCase(testCases[i]);
				}
		}
	}
}
