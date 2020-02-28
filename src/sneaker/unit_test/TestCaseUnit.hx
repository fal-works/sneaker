package sneaker.unit_test;

import sneaker.print.Printer;
import sneaker.print.PrinterSettings;
import sneaker.common.Exception;

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
		final useBufferPreviousValue = PrinterSettings.useBuffer;
		PrinterSettings.useBuffer = true;
		#end

		++record.caseCount;

		var exceptionCaught = false;
		try {
			run();
		} catch (exception:Exception) {
			exception.appendCallStack = TesterSettings.showCallStack;
			TesterSettings.exceptionLogType.print('Exception caught: ${exception}');
			exceptionCaught = true;
		} catch (caught:Null<Dynamic>) {
			@:nullSafety(Off)
			final value: Dynamic = if (caught != null) caught else "null";

			if (TesterSettings.rethrowUnknownExceptions) throw value;

			TesterSettings.exceptionLogType.print('Unknown exception caught: ${value}');
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
		if (passed && TesterSettings.hidePassedResults)
			Printer.buffer.clear();
		else
			Printer.buffer.flush();

		PrinterSettings.useBuffer = useBufferPreviousValue;
		#end
	}
}
