package sneaker.tester;

class TestCaseNodeExtension {
	/**
	 * Recursively runs each test case beginning at `node, separating with a new line.
	 */
	public static function run(node:TestCaseNode):Void {
		switch (node) {
			case Branch(children):
				for (child in children) {
					run(child);
				}
			case Leaf(unit):
				unit.runTestCaseUnit();
		}
	}
}
