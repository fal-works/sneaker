package;

// dunno how to do tests!
class Main {
	static function main() {
		sneaker.unit_test.TesterSettings.hidePassedResults = true;

		test(testCaseGroup([sneaker.LogTest.all, sneaker.AssertionTest.all]));
	}
}
