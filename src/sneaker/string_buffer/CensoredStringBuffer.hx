package sneaker.string_buffer;

/**
 * Special wrapper of `std.StringBuf`.
 * Each time you try to add, the value is processed and checked if it should really be added.
 */
@:using(sneaker.string_buffer.StringBufferExtension)
class CensoredStringBuffer {
	static final defaultOnAdd = (_s: String) -> true;

	/**
	 * Function that receives any value being added and
	 * checks if it should eventually be added to `this`.
	 */
	public var onAdd: (addingString: String) -> Bool;

	/** The length of stored string in characters. */
	public var length(get, never): Int;

	inline function get_length()
		return data.length;

	/**
	 * Internal `std.StringBuf` instance that actually stores the string.
	 */
	var data = new StringBuf();

	/**
	 * @param onAdd (optional) Every time you try to add a value to `this`,
	 * `onAdd()` will receive and process that value.
	 * `onAdd()` should return `false` if the value should not eventually be added to `this`.
	 */
	public function new(?onAdd: (addingString: String) -> Bool) {
		this.onAdd = if (onAdd != null) onAdd else defaultOnAdd;
	}

	/**
	 * Adds `x` by the following procedure:
	 * 1. Converts `x` to a `String` value.
	 * 2. Runs `this.onAdd()` passing that string value.
	 * 3. Only if `this.onAdd()` returns `true`, adds the string value to `this`.
	 */
	public function add<T>(x: T) {
		final s = Std.string(x);
		if (onAdd(s)) data.add(s);
	}

	/**
	 * Adds `x` to `this` ignoring `this.onAdd`. Same as `StringBuf.add()`.
	 */
	public inline function addDirect<T>(x: T) {
		data.add(x);
	}

	public function addChar(c: Int): Void {
		final s = String.fromCharCode(c);
		if (onAdd(s)) data.addChar(c);
	}

	/**
	 * Adds `x` to `this` ignoring `this.onAdd`. Same as `StringBuf.add()`.
	 */
	public inline function addCharDirect<T>(c: Int): Void {
		data.addChar(c);
	}

	public function addSub(
		s: String,
		pos: Int,
		?len: Int
	): Void {
		final subS = s.substr(pos, len);
		if (onAdd(subS)) data.add(subS);
	}

	public inline function addSubDirect(
		s: String,
		pos: Int,
		?len: Int
	): Void {
		data.addSub(s, pos, len);
	}

	public function toString(): String {
		return data.toString();
	}
}
