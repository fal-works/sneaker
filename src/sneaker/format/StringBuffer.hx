package sneaker.format;

/**
 * Extended from `std.StringBuf`.
 *
 * Differences:
 * - Using `sneaker.format.StringBufExtension`
 * - Runs `this.onAdd()` every time a value is added
 */
@:using(sneaker.format.StringBufExtension)
class StringBuffer extends StringBuf {
	static final defaultOnAdd = (_s: String) -> true;

	/**
	 * Function that receives any value being added and
	 * checks if it should eventually be added to `this`.
	 */
	public var onAdd: (addedString: String) -> Bool;

	/**
	 * @param onAdd (optional) Every time you try to add a value to `this`,
	 * `onAdd()` will receive and process that value.
	 * `onAdd()` should return `false` if the value should not eventually be added to `this`.
	 */
	public function new(?onAdd: (addedString: String) -> Bool) {
		super();
		this.onAdd = if (onAdd != null) onAdd else defaultOnAdd;
	}

	/**
	 * Adds `x` by the following procedure:
	 * 1. Converts `x` to a `String` value.
	 * 2. Runs `this.onAdd()` passing that string value.
	 * 3. Only if `this.onAdd()` returns `true`, adds the string value to `this`.
	 */
	override public function add<T>(x: T) {
		final s = Std.string(x);
		if (onAdd(s)) super.add(s);
	}

	/**
	 * Adds `x` to `this` ignoring `this.onAdd`. Same as `StringBuf.add()`.
	 */
	public function addDirect<T>(x: T) {
		super.add(x);
	}
}
