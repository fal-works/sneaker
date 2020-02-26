package sneaker;

import sneaker.assertion.Asserter.*;
import sneaker.tag.Tag;
import sneaker.log.Print.println;

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
	public static final assertTagFalse = () -> {
		describe("This raises an exception because the tag has wrong name.");
		final tag = new Tag("someTagName");
		tag.name = "someTagName";
		assert(tag.name == "otherTagName", tag);
	};
	public static final assertTests = runCases.bind([assertTrue, assertFalse, assertTagFalse]);

	// unwrap
	public static final unwrapOk = () -> {
		final obj = {val: 1};
		describe('This prints "${obj}".');
		println(unwrap(obj));
	};
	public static final unwrapError = () -> {
		describe('This raises an exception because (obj) is null.');
		final obj:Null<Dynamic> = null;
		println(unwrap(obj));
	};
	public static final unwrapTagError = () -> {
		describe('This raises an exception with a tag name, because (obj) is null.');
		final obj:Null<Dynamic> = null;
		final relatedTag = new Tag("someTagName");
		println(unwrap(obj, relatedTag));
	};
	public static final unwrapTests = runCases.bind([unwrapOk, unwrapError, unwrapTagError]);

	// all
	public static final all = runCases.bind([assertTests, unwrapTests]);
}
