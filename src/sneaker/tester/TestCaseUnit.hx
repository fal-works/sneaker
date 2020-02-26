package sneaker.tester;

import sneaker.print.Print;
import sneaker.print.PrintBuffer;

@:structInit
class TestCaseUnit {
	public static final empty = new TestCaseUnit(() -> {}, Empty);

	public final run:() -> Void;
	public final type:TestCaseType;

	public function new(run:() -> Void, type:TestCaseType) {
		this.run = run;
		this.type = type;
	}

	/**
	 * Runs `testCase()` in `try/catch`. If anything caught, prints an ERROR log.
	 */
	public function runTestCaseUnit():Void {
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
			++TestResult.exceptionCount;
		}

		#if sneaker_print_buffer
		switch (type) {
			case Ok:
				Print.flushlnBuffer();
			case Exception:
				Print.flushlnBuffer();
			case Visual:
				Print.flushlnBuffer();
			case Empty:
		}

		Print.useBuffer = useBufferPreviousValue;
		#end
	}
}
