package sneaker.tester;

/**
 * Type of test cases, which indicates what kind of results is expected.
 */
enum TestCaseType {
	/** The test case should complete successfully. */
	Ok;

	/** The test case should fail and throw anything. */
	Fail;

	/** The result cannot be judged automatically and needs to be confirmed visually. */
	Visual;
}
