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

		var exceptionCaught = false;
		try {
			run();
		} catch (exception:Dynamic) {
			Tester.exceptionLogType.print('Exception caught:\n${exception}');
			exceptionCaught = true;
			++record.exceptionCount;
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
