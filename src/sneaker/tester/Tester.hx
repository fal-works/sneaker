package sneaker.tester;

using sneaker.format.PosInfosExtension;

import haxe.PosInfos;
import sneaker.log.LogType;
import sneaker.log.LogFormats;
import sneaker.print.Print;
import sneaker.print.Print.println;

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
	 * Prints a heading including position info, and the given description text on the next line.
	 *
	 * Call this at first in each test case function.
	 *
	 * `describe` can also be replaced with any custom function.
	 */
	public static dynamic function describe(text:String, ?pos:PosInfos):Void {
		println(StringTools.rpad('TestCase____${pos.formatClassMethodWithoutModule()}', "_", 100));
		descriptionLogType.print('Description: ${text}', null, pos);
	}

	public static function testCase(runFunction:() -> Void, expectedType:TestCaseType):TestCaseNode {
		return Leaf(new TestCaseUnit(runFunction, expectedType));
	}

	public static function testCaseGroup(testCases:Array<TestCaseNode>):TestCaseNode {
		return testCases.length == 0 ? emptyTestCase : Branch(testCases);
	}

	public static function test(testCasesRoot:TestCaseNode):Void {
		final useBufferPreviousValue = Print.useBuffer;
		Print.useBuffer = true;

		TestResult.reset();
		testCasesRoot.run();

		Print.useBuffer = useBufferPreviousValue;

		println('\n${TestResult.exceptionCount} exceptions.');
	}

	static final emptyTestCase:TestCaseNode = Leaf(TestCaseUnit.empty);
}
