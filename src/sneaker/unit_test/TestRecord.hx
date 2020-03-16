package sneaker.unit_test;

using sneaker.format.IntExtension;
using sneaker.format.StringLanguageExtension;

import sneaker.string_buffer.StringBuffer;

/**
	Class for storing test result.
**/
class TestRecord {
	public var caseCount = 0;
	public var passedCount = 0;
	public var unExpectedExceptionCount = 0;
	public var unExpectedOkCount = 0;
	public var visualCount = 0;

	public function new() {}

	public function toString() {
		final buffer = new StringBuffer();

		// ---- super dirty implementation ----------------------------------------

		{
			final count = caseCount.addLeadingSpaces(3);
			final cases = "case".formatNounPluralS(caseCount);
			buffer.addLf('$count $cases tested.');
		};

		{
			final count = passedCount.addLeadingSpaces(3);
			final cases = "case".formatNounPluralS(passedCount);
			buffer.addLf('$count $cases passed.');
		};

		if (unExpectedExceptionCount > 0) {
			final count = unExpectedExceptionCount.addLeadingSpaces(3);
			final cases = "case".formatNounPluralS(unExpectedExceptionCount);
			final exceptions = "exception".formatNounPluralS(unExpectedExceptionCount);
			buffer.addLf('${count} ${cases} raised unexpected $exceptions.');
		}

		final oneOk = unExpectedOkCount == 1;
		if (unExpectedOkCount > 0) {
			final count = unExpectedOkCount.addLeadingSpaces(3);
			final cases = "case".formatNounPluralS(unExpectedOkCount);
			final they = oneOk ? "it" : "they";
			buffer.addLf('$count $cases did not raise any exception even though $they should.');
		}

		if (visualCount > 0) {
			final count = visualCount.addLeadingSpaces(3);
			final cases = "case".formatNounPluralS(visualCount);
			final need = "need".formatVerbSingularS(visualCount);
			buffer.addLf('$count $cases $need to be confirmed visually.');
		}

		return buffer.toString();
	}
}
