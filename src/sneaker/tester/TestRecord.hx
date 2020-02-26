package sneaker.tester;

using sneaker.format.IntExtension;

import sneaker.format.StringBuffer;

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

		final oneCase = caseCount == 1;
		final onePassed = passedCount == 1;
		final oneExeption = unExpectedExceptionCount == 1;
		final oneOk = unExpectedOkCount == 1;
		final oneVisual = visualCount == 1;

		buffer.addLf('${caseCount.addLeadingSpaces(3)} case${oneCase ? "" : "s"} tested.');
		buffer.addLf('${passedCount.addLeadingSpaces(3)} case${onePassed ? "" : "s"} passed.');

		if (unExpectedExceptionCount > 0)
			buffer.addLf('${unExpectedExceptionCount.addLeadingSpaces(3)} unexpected exception${oneExeption ? "" : "s"} caught.');

		if (unExpectedOkCount > 0)
			buffer.addLf('${unExpectedOkCount.addLeadingSpaces(3)} case${oneOk ? "" : "s"} did not raise any exception even though ${oneOk ? "it" : "they"} should.');

		if (visualCount > 0)
			buffer.addLf('${visualCount.addLeadingSpaces(3)} case${oneVisual ? "" : "s"} need${oneVisual ? "s" : ""} to be confirmed visually.');

		return buffer.toString();
	}
}
