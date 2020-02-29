package sneaker.format;

class IntExtension {
	static final zero = "0";
	static final space = " ";

	/**
		Casts `Int` to `String`, left-padding with zeros.
	**/
	public static function addLeadingZeros(value: Int, digitCount: Int): String {
		return StringTools.lpad(Std.string(value), zero, digitCount);
	}

	/**
		Casts `Int` to `String`, left-padding with spaces.
	**/
	public static function addLeadingSpaces(value: Int, digitCount: Int): String {
		return StringTools.lpad(Std.string(value), space, digitCount);
	}
}
