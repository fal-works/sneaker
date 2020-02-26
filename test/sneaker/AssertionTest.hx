package sneaker;

import sneaker.assertion.Asserter.*;
import sneaker.tag.Tag;
import sneaker.print.Print.println;

class AssertionTest {
	// assert
	public static final assertTrue = testCase({
		description: "",
		run: () -> {
			describe("This has no effect.");
			assert(1 < 2);
		},
		type: Ok
	});
	public static final assertFalse = testCase({
		description: "",
		run: () -> {
			describe("This raises an exception because (thisIsLess < thisIsGreater) is false.");
			final thisIsLess = 2;
			final thisIsGreater = 1;
			assert(thisIsLess < thisIsGreater);
		},
		type: Exception
	});
	public static final assertTagFalse = testCase({
		description: "",
		run: () -> {
			describe("This raises an exception because the tag has wrong name.");
			final tag = new Tag("someTagName");
			tag.name = "someTagName";
			assert(tag.name == "otherTagName", tag);
		},
		type: Exception
	});
	public static final assertTests = testCaseGroup([assertTrue, assertFalse, assertTagFalse]);

	// unwrap
	public static final unwrapOk = testCase({
		description: "",
		run: () -> {
			final obj = {val: 1};
			describe('This prints "${obj}".');
			println(unwrap(obj));
		},
		type: Visual
	});
	public static final unwrapError = testCase({
		description: "",
		run: () -> {
			describe('This raises an exception because (obj) is null.');
			final obj:Null<Any> = null;
			println(unwrap(obj));
		},
		type: Exception
	});
	public static final unwrapTagError = testCase({
		description: "",
		run: () -> {
			describe('This raises an exception with a tag name, because (obj) is null.');
			final obj:Null<Any> = null;
			final relatedTag = new Tag("someTagName");
			println(unwrap(obj, relatedTag));
		},
		type: Exception
	});
	public static final unwrapTests = testCaseGroup([unwrapOk, unwrapError, unwrapTagError]);

	// all
	public static final all = testCaseGroup([assertTests, unwrapTests]);
}
