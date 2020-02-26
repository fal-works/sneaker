package sneaker.print;

import sneaker.format.StringBuffer;
import sneaker.assertion.Asserter.unwrap;

class PrintBuffer {
	/**
	 * The top element of the buffer stack.
	 */
	public static var current(get, never):StringBuffer;
	static inline function get_current():StringBuffer {
		return stack[topIndex];
	}

	/**
	 * Pushes `buffer` to the buffer stack.
	 */
	public static function push(buffer:StringBuffer):Void {
		stack.push(buffer);
		++topIndex;
	}

	/**
	 * Creates a new `StringBuffer` and pushes it to the buffer stack.
	 * @return The newly created buffer.
	 */
	public static function pushNew() {
		final newBuffer = new StringBuffer();
		push(newBuffer);

		return newBuffer;
	}

	/**
	 * Pops the top element of the buffer stack.
	 * If this operation empties the stack, a new buffer element is automatically added.
	 */
	public static function pop():StringBuffer {
		final popped = unwrap(stack.pop());

		if (topIndex > 0)
			--topIndex;
		else
			stack.push(new StringBuffer());

		return popped;
	}

	/**
	 * Drops the current buffer by `pop()` and prints its content by `Print.printlnDirect()`.
	 */
	public static function flush():Void {
		Print.printlnDirect(pop().toString());
	}

	/**
	 * Clears the buffer stack.
	 */
	public static function clear():Void {
		stack.resize(0);
		stack.push(new StringBuffer());
		topIndex = 0;
	}

	static final stack:Array<StringBuffer> = [new StringBuffer()];
	static var topIndex = 0;
}
