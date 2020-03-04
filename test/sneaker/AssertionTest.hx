package sneaker;

import sneaker.assertion.Asserter.*;
import sneaker.tag.Tag;
import sneaker.print.Printer.println;

class AssertionTest {
	// assert
	public static final assertTrue = testCase(() -> {
		describe("This has no effect.");
		assert(1 < 2);
	}, Ok);
	public static final assertFalse = testCase(() -> {
		describe("This raises an exception because (thisIsLess < thisIsGreater) is false.");
		final thisIsLess = 2;
		final thisIsGreater = 1;
		assert(thisIsLess < thisIsGreater);
	}, Fail);
	public static final assertTagFalse = testCase(() -> {
		describe("This raises an exception because the tag has wrong name.");
		final tag = new Tag("someTagName");
		assert(tag.name == "otherTagName", tag);
	}, Fail);
	public static final assertTests = testCaseGroup([
		assertTrue,
		assertFalse,
		assertTagFalse
	]);

	// unwrap
	public static final unwrapOk = testCase(() -> {
		final obj = {val: 1};
		describe('This prints "${obj}".');
		println(unwrap(obj));
	}, Visual);
	public static final unwrapError = testCase(() -> {
		describe('This raises an exception because (obj) is null.');
		final obj: Null<Any> = null;
		println(unwrap(obj));
	}, Fail);
	public static final unwrapTagError = testCase(() -> {
		describe('This raises an exception with a tag name, because (obj) is null.');
		final obj: Null<Any> = null;
		final relatedTag = new Tag("someTagName");
		println(unwrap(obj, relatedTag));
	}, Fail);
	public static final unwrapTests = testCaseGroup([
		unwrapOk,
		unwrapError,
		unwrapTagError
	]);

	// other
	public static final complex = testCase(() -> {
		describe('This gives an odd result!');
		final array = ["a", "b", "c"];
		assert(array.pop() == "c");
	}, Fail);
	public static final otherTests = testCaseGroup([
		complex
	]);

	// all
	public static final all = testCaseGroup([
		assertTests,
		unwrapTests,
		otherTests
	]);
}
