package sneaker.tester;

/**
 * Naive tree structure of test cases, internally used by `Tester` class.
 */
@:using(sneaker.tester.TestCaseNodeExtension)
enum TestCaseNode {
	Branch(children: Array<TestCaseNode>);
	Leaf(unit: TestCaseUnit);
	None;
}
