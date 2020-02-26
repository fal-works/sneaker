package sneaker.tester;

import sneaker.print.Print;
import sneaker.print.PrintBuffer;

@:structInit
class TestCaseUnit {
	public final run:() -> Void;
	public final type:TestCaseType;

	public function new(run:() -> Void, type:TestCaseType) {
		this.run = run;
		this.type = type;
	}

	/**
	 * Runs `this.run()` in `try/catch`.
	 * If anything caught, prints it and goes on without throwing again.
	 */
	public function runAndCheck(record:TestRecord):Void {
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

		switch (type) {
			case Ok:
				Print.flushlnBuffer();
				if (exceptionCaught)
					++record.unExpectedExceptionCount;
			case Exception:
				Print.flushlnBuffer();
				if (!exceptionCaught)
					++record.unExpectedOkCount;
			case Visual:
				Print.flushlnBuffer();
				++record.visualCount;
				if (exceptionCaught)
					++record.unExpectedExceptionCount;
		}

		#if sneaker_print_buffer
		switch (type) {
			case Ok:
				Print.flushlnBuffer();
			case Exception:
				Print.flushlnBuffer();
			case Visual:
				Print.flushlnBuffer();
		}

		Print.useBuffer = useBufferPreviousValue;
		#end
	}
}
