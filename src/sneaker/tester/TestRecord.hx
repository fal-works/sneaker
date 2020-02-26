package sneaker.tester;

/**
 * Class for storing test result.
 */
 class TestRecord {
	public var exceptionCount = 0;

	public function new() {}

	public function toString() {
		return '${exceptionCount} exceptions.';
	}
}
