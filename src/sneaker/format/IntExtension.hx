package sneaker.format;

@:nullSafety(Strict)
class IntExtension {
	static final zero = "0";

	/**
	 * Casts `Int` to `String`, left-padding with zeros.
	 */
	public static function addLeadingZeros(value:Int, digitCount:Int):String {
		return StringTools.lpad(Std.string(value), zero, digitCount);
	}
}
