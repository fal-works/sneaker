package sneaker.tester;

using sneaker.format.PosInfosExtension;

import haxe.PosInfos;
import sneaker.log.LogType;
import sneaker.log.LogFormats;
import sneaker.print.Print;
import sneaker.print.Print.println;
import sneaker.print.PrintBuffer;

/**
 * Class for storing test result.
 * Will be reset everytime when `Tester.test()` is called.
 */
class TestResult {
	public static var exceptionCount = 0;

	public static function reset()
		exceptionCount = 0;
}

/**
 * Set of functions for doing simple unit tests.
 */
class Tester {
	/**
	 * Log type used in `describe()` (unless you replace the `describe` function).
	 * Replace or edit this type for formatting descriptions.
	 * The filters have no effect.
	 */
	public static var descriptionLogType = {
		final type = new LogType("[TEST]  ");
		type.logFormat = LogFormats.prefixMessage;
		type;
	}

	/**
	 * Log type used when an exception is caught in `runCase()`.
	 * Replace or edit this type for formatting that exception log.
	 * The filters have no effect.
	 */
	public static var exceptionLogType = new LogType("[TEST]  ");

	/**
	 * Prints position info and a given description text.
	 * Can be used as a heading of each test case.
	 * You can also replace this with any custom function.
	 */
	public static dynamic function describe(text:String, ?pos:PosInfos):Void {
		println(StringTools.rpad('TestCase____${pos.formatClassMethodWithoutModule()}', "_", 100));
		descriptionLogType.print('Description: ${text}', null, pos);
	}

	public static function testCase(unit:TestCaseUnit):TestCaseNode {
		return Leaf(unit);
	}

	public static function testCaseGroup(testCases:Array<TestCaseNode>):TestCaseNode {
		return testCases.length == 0 ? emptyTestCase : Branch(testCases);
	}

	public static function test(testCasesRoot:TestCaseNode):Void {
		final useBufferPreviousValue = Print.useBuffer;
		Print.useBuffer = true;

		TestResult.reset();
		runCases(testCasesRoot);
		println('\n${TestResult.exceptionCount} exception.');

		Print.useBuffer = useBufferPreviousValue;
	}

	static final emptyTestCase:TestCaseNode = Leaf(TestCaseUnit.empty);

	/**
	 * Runs `testCase()` in `try/catch`. If anything caught, prints an ERROR log.
	 */
	static function runCaseUnit(unit:TestCaseUnit):Void {
		var exceptionCaught = false;
		try {
			unit.run();
		} catch (exception:Dynamic) {
			exceptionLogType.print('Exception caught:\n${exception}');
			exceptionCaught = true;
			++TestResult.exceptionCount;
		}

		switch (unit.type) {
			case Ok:
				PrintBuffer.flush();
			case Exception:
				PrintBuffer.flush();
			case Visual:
				PrintBuffer.flush();
			case Empty:
		}
	}

	/**
	 * Runs each element of `testCases`, separating with a new line.
	 */
	static function runCases(testCases:TestCaseNode):Void {
		switch(testCases) {
			case Branch(children):
				final length = children.length;

				switch (length) {
					case 0:
						return;
					case 1:
						runCases(children[0]);
					default:
						runCases(children[0]);

						for (i in 1...length) {
							println("");
							runCases(children[i]);
						}
				}
			case Leaf(unit):
				runCaseUnit(unit);
		}
	}
}
