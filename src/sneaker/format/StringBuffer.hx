package sneaker.format;

/**
 * Extended from `StringBuf` in the standard library.
 *
 * Differences:
 * - Does a max length check in `add()`
 * - Using `sneaker.format.StringBufExtension`
 */
@:using(sneaker.format.StringBufExtension)
class StringBuffer extends StringBuf {
	public var dataMaxLength:Int;

	/**
	 * @param maxLength The max length of string that this buffer can contain.
	 */
	public function new(maxLength = 16384) {
		super();
		this.dataMaxLength = maxLength;
	}

	/**
	 * Adds `x` to `this` unless the total length will not exceed `this.dataMaxLength`.
	 *
	 * Compilation flag:
	 * - Set `sneaker_string_buffer_length_check_disable` to true
	 *   for disabling the max length check.
	 */
	override public inline function add<T>(x:T) {
		#if !sneaker_string_buffer_length_check_disable
		final s = Std.string(x);

		if (this.length + s.length < this.dataMaxLength)
			super.add(s);
		#else
		super.add(x);
		#end
	}
}
