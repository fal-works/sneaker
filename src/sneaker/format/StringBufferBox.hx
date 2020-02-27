package sneaker.format;

/**
 * Wrapper of `StringBuffer` that can limit the number of additions and the maximum total length.
 */
class StringBufferBox {
	public var buffer(default, null): StringBuffer;
	public var onFull: (bufferedString: String) -> Void;
	public var maxLength: Int;
	public var maxCount: Int;
	public var currentCount: Int;

	/**
	 * @param onFull Callback function that receives the buffered string.
	 * If a value `s` is added to `this.buffer` and the operation results in exceeding the threshold
	 * (`maxLength` and `maxCount`), the string that the current buffer contains is passed to `onFull`
	 * and `s` is added to a new buffer, dropping the old one.
	 */
	public function new(onFull: (bufferedString: String) -> Void, maxLength = 8192, maxCount = 1024) {
		this.buffer = new StringBuffer();
		this.onFull = onFull;
		this.maxLength = maxLength;
		this.maxCount = maxCount;
		this.currentCount = 0;
	}

	/**
	 * Clears the buffer.
	 */
	public function clear(): Void {
		buffer = createNewBuffer();
		currentCount = 0;
	}

	/**
	 * Clears and adds `s` with the following procedure:
	 * 1. Clears the buffer.
	 * 2. Adds `s` to the cleared buffer without invoking its `onAdd()`.
	 */
	public function clearAdd(s: String): Void {
		final newBuffer = createNewBuffer();
		newBuffer.addDirect(s);
		this.buffer = newBuffer;
		currentCount = 1;
	}

	/**
	 * Flushes the current buffer with the following procedure:
	 * 1. Runs `this.onFull()` with the current buffer data whether or not full.
	 * 2. Clears the buffer.
	 */
	public inline function flush(): Void {
		runOnFull();
		clear();
	}

	/**
	 * Flushes the current buffer and adds `s` with the following procedure:
	 * 1. Runs `this.onFull()` with the current buffer data whether or not full.
	 * 2. Clears the buffer.
	 * 3. Adds `s` to the cleared buffer without invoking its `onAdd()`.
	 */
	 public inline function flushAdd(s: String): Void {
		runOnFull();
		clearAdd(s);
	}

	public function toString(): String {
		return buffer.toString();
	}

	/**
	 * Passes the current buffer data to `this.onFull()`.
	 */
	inline function runOnFull(): Void {
		onFull(buffer.toString());
	}

	/**
	 * Callback function that will be called from the buffer every time a value is added.
	 */
	dynamic function onAddBuffer(s: String): Bool {
		++currentCount;

		if (currentCount <= maxCount && buffer.length + s.length <= maxLength) {
			return true;
		} else {
			flushAdd(s);
			return false;
		}
	}

	function createNewBuffer(): StringBuffer {
		return new StringBuffer(onAddBuffer);
	}
}
