package sneaker.print;

import sneaker.format.StringBuffer;
import sneaker.format.StringBufferBox;

@:forward(flush, clear)
abstract PrintBuffer(StringBufferBox) to StringBufferBox {
	public inline function new(?maxLength: Int, ?maxCount: Int) {
		this = new StringBufferBox(PrintCallbacks.printDirect, maxLength, maxCount);
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
