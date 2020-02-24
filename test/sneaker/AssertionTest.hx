package sneaker;

import sneaker.assertion.Asserter.*;
import sneaker.log.Print.println;

@:nullSafety(Strict)
class AssertionTest {
	// assert
	public static final assertTrue = () -> {
		describe("This has no effect.");
		assert(1 < 2);
	};
	public static final assertFalse = () -> {
		describe("This raises an exception because (thisIsLess < thisIsGreater) is false.");
		final thisIsLess = 2;
		final thisIsGreater = 1;
		assert(thisIsLess < thisIsGreater);
	};
	public static final assertTests = runCases.bind([assertTrue, assertFalse]);

	// unwrap
	public static final unwrapOk = () -> {
		final obj = {val: 1};
		describe('This prints "${obj}".');
		println(unwrap(obj));
	};
	public static final unwrapError = () -> {
		final obj:Null<Dynamic> = null;
		describe('This raises an exception because (obj) is null.');
		println(unwrap(obj));
	};
	public static final unwrapTests = runCases.bind([unwrapOk, unwrapError]);

	// all
	public static final all = runCases.bind([assertTests, unwrapTests]);
}
