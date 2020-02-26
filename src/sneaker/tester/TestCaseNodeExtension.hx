package sneaker.tester;

class TestCaseNodeExtension {
	/**
	 * Recursively runs each test case beginning at `node, separating with a new line.
	 */
	public static function run(node:TestCaseNode, record:TestRecord):TestRecord {
		switch (node) {
			case Branch(children):
				for (child in children) {
					run(child, record);
				}
			case Leaf(unit):
				unit.runAndCheck(record);
		}

		return record;
	}
}
