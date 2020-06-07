package sneaker.print;

import sneaker.string_buffer.CensoredStringBuffer;
import sneaker.string_buffer.StringBufferBox;

/**
	Thin wrapper of `sneaker.string_buffer.StringBufferBox`.
	It prints its data when you call `flush()`, or automatically if it is getting full.
	Mainly used by the `Printer` class (`Printer.buffer`).

	Compilation flag:
	- If `sneaker_print_buffer_disable` is set, `Printer.buffer` is not used or referred from anywhere
		but you can still use it manually or even make another `PrinterBuffer` instance for your own purpose.
**/
@:forward(flush, clear)
abstract PrintBuffer(StringBufferBox) to StringBufferBox {
	public extern inline function new(?maxLength: Int, ?maxCount: Int) {
		this = new StringBufferBox(
			PrinterCallbacks.printDirect,
			maxLength,
			maxCount
		);
	}

	/**
		Current buffer data (`CensoredStringBuffer` class, which extends `std.StringBuf`).

		Can also be used to add values directly, however note that this does not always refer to the same instance.
		@see `sneaker.string_buffer.StringBufferBox`
	**/
	public var current(get, never): CensoredStringBuffer;

	extern inline function get_current()
		return this.buffer;
}
