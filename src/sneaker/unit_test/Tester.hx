package sneaker.unit_test;

using sneaker.format.PosInfosExtension;

import haxe.PosInfos;
import sneaker.log.LogType;
import sneaker.log.LogFormats;
import sneaker.print.Printer.println;

/**
 * Set of functions for doing simple unit tests.
 */
class Tester {
	/**
	 * If set to `true`, the results of passed test cases are not displayed individually.
	 *
	 * This helps you to check only the unexpected results or the cases that should confirmed visually
	 * (and you can still see the aggregate results including the passed ones).
	 *
	 * Compilation flag:
	 * - If `sneaker_print_buffer_disable` is set, this variable has no effect.
	 */
	public static var hidePassedResults = false;

	/**
	 * If `true`, any caught exception (extending `sneaker.common.Exception`) is displayed
	 * with succeding call stack information.
	 * May not be that useful for simple test cases.
	 */
	public static var showCallStack = false;

	/**
	 * If `true`, any value that is caught in the `try/catch` and does not extend `sneaker.common.Exception`
	 * will be thrown again instead of printing it and moving on next test cases.
	 */
	public static var rethrowUnknownExceptions = false;

	/**
	 * Log type used in `Tester.describe()` (unless you replace the
	 * `Tester.describe` function and stop using `Tester.descriptionLogType`).
	 * Replace or edit this type for changing the format of descriptions.
	 * The filters have no effect.
	 */
	public static var descriptionLogType = {
		final type = new LogType("[TEST]  ");
		type.logFormat = LogFormats.prefixMessage;
		type;
	}

	/**
	 * Log type used when an exception is caught during the test.
	 * Replace or edit this type for changing the format of that exception log.
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
	 * @return A test case node that can be grouped by `Tester.testCaseGroup()` or executed by `Tester.test()`.
	 */
	public static function testCase(
		runFunction: () -> Void,
		expectedType: TestCaseType
	): TestCaseNode {
		return Leaf(new TestCaseUnit(runFunction, expectedType));
	}

	/**
	 * Groups `testCases` and wraps them as a node as if they are a single test case,
	 * which enables you to group it again together with another nodes.
	 * @return A test case node that can be grouped by `Tester.testCaseGroup()` or executed by `Tester.test()`.
	 */
	public static function testCaseGroup(testCases: Array<TestCaseNode>): TestCaseNode {
		return testCases.length > 0 ? Branch(testCases) : None;
	}

	/**
	 * Executes all test cases that are wrapped in `testCaseRoot` and prints the result.
	 * @param testCaseRoot Any node created by `Tester.testCase()` or `Tester.testCaseGroup()`.
	 */
	public static function test(testCaseRoot: TestCaseNode): Void {
		final result = testCaseRoot.run(new TestRecord());

		println(result);
	}
}
