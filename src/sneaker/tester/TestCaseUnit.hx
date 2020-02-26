package sneaker.tester;

import sneaker.print.Print;
import sneaker.print.PrintBuffer;

/**
 * Class for each test case, internally used by `Tester` class.
 */
class TestCaseUnit {
	public final run: () -> Void;
	public final type: TestCaseType;

	public function new(run: () -> Void, type: TestCaseType) {
		this.run = run;
		this.type = type;
	}

	/**
	 * Runs `this.run()` in `try/catch`.
	 * If anything caught, prints it and goes on without throwing again.
	 */
	public function runAndCheck(record: TestRecord): Void {
		#if sneaker_print_buffer
		final useBufferPreviousValue = Print.useBuffer;
		Print.useBuffer = true;
		PrintBuffer.pushNew();
		#end

		++record.caseCount;

		var exceptionCaught = false;
		try {
			run();
		} catch (exception:Dynamic) {
			Tester.exceptionLogType.print('Exception caught:\n${exception}');
			exceptionCaught = true;
		}

		var passed = true;

		switch (type) {
			case Ok:
				if (exceptionCaught) {
					++record.unExpectedExceptionCount;
					passed = false;
				}
			case Exception:
				if (!exceptionCaught) {
					++record.unExpectedOkCount;
					passed = false;
				}
			case Visual:
				passed = false;
				if (exceptionCaught)
					++record.unExpectedExceptionCount;
				else
					++record.visualCount;
		}

		if (passed)
			++record.passedCount;

		#if sneaker_print_buffer
		if (!passed || !Tester.hidePassedResult)
			Print.flushlnBuffer();

		Print.useBuffer = useBufferPreviousValue;
		#end
	}
}
