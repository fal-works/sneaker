package sneaker.tester;

enum TestCaseNode {
	Branch(children:Array<TestCaseNode>);
	Leaf(unit:TestCaseUnit);
}
