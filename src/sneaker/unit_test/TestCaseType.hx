package sneaker.unit_test;

/**
	Type of test cases, which indicates what kind of results is expected.
**/
enum TestCaseType {
	/**
		The test case should complete successfully.
	**/
	Ok;

	/**
		The test case should fail and throw anything.

		Note that it will not be automatically checked what kind of exception.
	**/
	Fail;

	/**
		The result cannot be judged automatically and needs to be confirmed visually.
	**/
	Visual;
}
