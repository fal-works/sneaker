package sneaker.print;

import sneaker.format.StringBuffer;
import sneaker.format.StringBufferBox;

/**
 * Thin wrapper of `sneaker.format.StringBox`.
 * It prints its data when you call `flush()`, or automatically if it is getting full.
 * Mainly used by the `Print` class.
 *
 * Compilation flag:
 * - If `sneaker_print_buffer_disable` is set, it is not used by the `Print` class but
 *   you can still make another `PrintBuffer` instance and use it for your own purpose.
 */
@:forward(flush, clear)
abstract PrintBuffer(StringBufferBox) to StringBufferBox {
	public inline function new(?maxLength: Int, ?maxCount: Int) {
		this = new StringBufferBox(
			PrintCallbacks.printDirect,
			maxLength,
			maxCount
		);
	}

	/**
	 * The underlying `StringBuffer`.
	 * Note that this does not always refer to the same instance.
	 * @see `sneaker.format.StringBufferBox`
	 */
	public var current(get, never): StringBuffer;

	inline function get_current()
		return this.buffer;
}
