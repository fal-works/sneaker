package sneaker.unit_test;

/**
 * Naive tree structure of test cases, internally used by `Tester` class.
 */
@:using(sneaker.unit_test.TestCaseNodeExtension)
enum TestCaseNode {
	Branch(children: Array<TestCaseNode>);
	Leaf(unit: TestCaseUnit);
	None;
}
