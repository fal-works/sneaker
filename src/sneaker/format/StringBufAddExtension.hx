package sneaker.format;

@:nullSafety(Strict)
class StringBufAddExtension {
	static inline final twoSpaces = "  ";

	/**
	 * Adds Line Feed (i.e. "\n").
	 * @return The given `StringBuf`.
	 */
	public static inline function lf(buf:StringBuf):StringBuf {
		buf.add('\n');
		return buf;
	}

	/**
	 * Adds Line Feed and `s`.
	 * @return The given `StringBuf`.
	 */
	public static inline function lfAdd(buf:StringBuf, s:String):StringBuf {
		buf.add('\n${s}');
		return buf;
	}

	/**
	 * Adds `indent` and `s`.
	 * @param indent Defaults 2 spaces.
	 * @return The given `StringBuf`.
	 */
	public static inline function indentAdd(buf:StringBuf, s:String, indent:String = twoSpaces):StringBuf {
		buf.add('${indent}${s}');
		return buf;
	}

	/**
	 * Adds Line Feed, `indent` and `s`.
	 * @return The given `StringBuf`.
	 */
	public static inline function lfIndentAdd(buf:StringBuf, s:String, indent:String = twoSpaces):StringBuf {
		buf.add('\n${indent}${s}');
		return buf;
	}
}
