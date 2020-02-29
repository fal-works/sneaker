package sneaker.assertion;

/**
	Either `Assertion` or `Unwrap`.
**/
enum AssertionType {
	/** Called by `Asserter.assert()`. **/
	Assertion;

	/** Called by `Asserter.unwrap()`. **/
	Unwrap;
}
