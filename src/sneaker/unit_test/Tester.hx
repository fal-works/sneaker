package sneaker.unit_test;

import haxe.PosInfos;
import sneaker.print.Printer.println;

/**
	Set of functions for doing simple unit tests.
**/
class Tester {
	/**
		Prints a heading including position info, and (if provided) the given description text on the next line.

		Call this at first in each test case function.
	**/
	public static inline function describe(?text: String, ?pos: PosInfos): Void {
		TesterSettings.describe(text, pos);
	}

	/**
		Creates a test case node.
		Wrap each of your test case functions with this.

		@param runFunction
		@return A test case node that can be grouped by `Tester.testCaseGroup()` or executed by `Tester.test()`.
	**/
	public static function testCase(
		runFunction: () -> Void,
		expectedType: TestCaseType
	): TestCaseNode {
		return Leaf(new TestCaseUnit(runFunction, expectedType));
	}

	/**
		Groups `testCases` and wraps them as a node as if they are a single test case,
		which enables you to group it again together with another nodes.
		@return A test case node that can be grouped by `Tester.testCaseGroup()` or executed by `Tester.test()`.
	**/
	public static function testCaseGroup(testCases: Array<TestCaseNode>): TestCaseNode {
		return testCases.length > 0 ? Branch(testCases) : None;
	}

	/**
		Executes all test cases that are wrapped in `testCaseRoot` and prints the result.
		@param testCaseRoot Any node created by `Tester.testCase()` or `Tester.testCaseGroup()`.
	**/
	public static function test(testCaseRoot: TestCaseNode): Void {
		final result = testCaseRoot.run(new TestRecord());

		println(result.toString());
	}
}
