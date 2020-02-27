package sneaker.tester;

using sneaker.format.PosInfosExtension;

import haxe.PosInfos;
import sneaker.log.LogType;
import sneaker.log.LogFormats;
import sneaker.print.Print.println;

/**
 * Set of functions for doing simple unit tests.
 */
class Tester {
	/**
	 * If set to `true`, results of passed test cases are not displayed individually.
	 *
	 * This helps you to check only the unexpected results or the cases that should confirmed visually
	 * (and you can still see the aggregate results).
	 *
	 * Required: Compilation flag `sneaker_print_buffer` (if not set, this variable has no effect).
	 */
	public static var hidePassedResult = false;

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
	public static dynamic function describe(text: String, ?pos: PosInfos): Void {
		println(StringTools.rpad(
			'TestCase____${pos.formatClassMethodWithoutModule()}',
			"_",
			100
		));
		descriptionLogType.print('Description: ${text}', null, pos);
	}

	/**
	 * Creates a test case node.
	 * Wrap each of your test case functions with this.
	 *
	 * @param runFunction
	 * @param runFunction
	 * @return -> Void, expectedType:TestCaseType):TestCaseNode
	 */
	public static function testCase(
		runFunction: () -> Void,
		expectedType: TestCaseType
	): TestCaseNode {
		return Leaf(new TestCaseUnit(runFunction, expectedType));
	}

	public static function testCaseGroup(testCases: Array<TestCaseNode>): TestCaseNode {
		return testCases.length > 0 ? Branch(testCases) : None;
	}

	public static function test(testCasesRoot: TestCaseNode): Void {
		final result = testCasesRoot.run(new TestRecord());

		println(result);
	}
}
