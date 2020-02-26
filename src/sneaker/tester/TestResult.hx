package sneaker.tester;

/**
 * Class for storing test result.
 * Will be reset everytime when `Tester.test()` is called.
 */
 class TestResult {
	public static var exceptionCount = 0;

	public static function reset()
		exceptionCount = 0;
}
