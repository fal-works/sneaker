package sneaker.tester;

import sneaker.format.StringBuffer;

/**
 * Class for storing test result.
 */
class TestRecord {
	public var caseCount = 0;
	public var unExpectedExceptionCount = 0;
	public var unExpectedOkCount = 0;
	public var visualCount = 0;

	public function new() {}

	public function toString() {
		// super dirty implementation
		final passedCount = caseCount - visualCount - unExpectedExceptionCount - unExpectedOkCount;
		final onePassed = passedCount == 1;

		final oneCase = caseCount == 1;
		final oneExeption = unExpectedExceptionCount == 1;
		final oneOk = unExpectedOkCount == 1;
		final oneVisual = visualCount == 1;

		final buffer = new StringBuffer();
		buffer.addLf('${caseCount} case${oneCase ? "" : "s"} tested.');
		buffer.addLf('${passedCount} case${onePassed ? "" : "s"} passed.');

		if (unExpectedExceptionCount > 0)
			buffer.addLf('${unExpectedExceptionCount} unexpected exception${oneExeption ? "" : "s"} caught.');

		if (unExpectedOkCount > 0)
			buffer.addLf('${unExpectedOkCount} case${oneOk ? "" : "s"} did not raise any exception even though ${oneOk ? "it" : "they"} should.');

		if (visualCount > 0)
			buffer.addLf('${visualCount} case${oneVisual ? "" : "s"} need${oneVisual ? "s" : ""} to be confirmed visually.');

		return buffer.toString();
	}
}
