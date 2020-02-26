package sneaker.tester;

@:using(sneaker.tester.TestCaseNodeExtension)
enum TestCaseNode {
	Branch(children:Array<TestCaseNode>);
	Leaf(unit:TestCaseUnit);
	None;
}
