package sneaker.testrunner;

import haxe.PosInfos;
import sneaker.log.Log;
import sneaker.log.Print.printlnString;

class TestRunner {
	/**
	 * Prints position info and a description text.
	 * Can be used as a heading of each test case.
	 */
	public static function describe(text:String, ?pos:PosInfos):Void {
		if (pos != null)
			printlnString('____ ${pos.className}::${pos.methodName} ________________');

		printlnString('Description: ${text}');
	}

	/**
	 * Run `testCase()` in `try/catch`. If anything caught, prints an ERROR log.
	 */
	public static function runCase(testCase:() -> Void):Void {
		try {
			testCase();
		} catch (exception:Dynamic) {
			Log.error('Exception caught:\n${exception}');
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
