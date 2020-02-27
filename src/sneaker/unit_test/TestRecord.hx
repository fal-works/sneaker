package sneaker.unit_test;

using sneaker.format.IntExtension;
using sneaker.format.StringLanguageExtension;

import sneaker.format.StringBuffer;

// @formatter:off

/**
 * Class for storing test result.
 */
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

		inline function cases(count:Int) return "case".formatNounPluralS(count);

		buffer.addLf('${caseCount.addLeadingSpaces(3)} ${cases(caseCount)} tested.');
		buffer.addLf('${passedCount.addLeadingSpaces(3)} ${cases(passedCount)} passed.');

		if (unExpectedExceptionCount > 0)
			buffer.addLf('${unExpectedExceptionCount.addLeadingSpaces(3)} unexpected ${"exception".formatNounPluralS(unExpectedExceptionCount)} caught.');

		final oneOk = unExpectedOkCount == 1;
		if (unExpectedOkCount > 0)
			buffer.addLf('${unExpectedOkCount.addLeadingSpaces(3)} ${cases(unExpectedOkCount)} did not raise any exception even though ${oneOk ? "it" : "they"} should.');

		if (visualCount > 0)
			buffer.addLf('${visualCount.addLeadingSpaces(3)} ${cases(visualCount)} ${"need".formatVerbSingularS(visualCount)} to be confirmed visually.');

		return buffer.toString();
	}
}
