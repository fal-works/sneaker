package sneaker.unit_test;

import sneaker.print.Printer;

/**
 * Class for each test case, internally used by `Tester` class.
 */
@:structInit
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
		#if !sneaker_print_buffer_disable
		final useBufferPreviousValue = Printer.useBuffer;
		Printer.useBuffer = true;
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
			case Fail:
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

		Printer.println("");

		#if !sneaker_print_buffer_disable
		if (passed && Tester.hidePassedResult)
			Printer.buffer.clear();
		else
			Printer.buffer.flush();

		Printer.useBuffer = useBufferPreviousValue;
		#end
	}
}
