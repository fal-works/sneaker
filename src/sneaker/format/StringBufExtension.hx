package sneaker.format;

class StringBufExtension {
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
	public static inline function lfAdd<T>(buf:StringBuf, s:T):StringBuf {
		buf.add('\n${s}');
		return buf;
	}

	/**
	 * Adds `s` and Line Feed.
	 * @return The given `StringBuf`.
	 */
	public static inline function addLf<T>(buf:StringBuf, s:T):StringBuf {
		buf.add('${s}\n');
		return buf;
	}

	/**
	 * Adds `indent` and `s`.
	 * @param indent Defaults to 2 spaces.
	 * @return The given `StringBuf`.
	 */
	public static inline function indentAdd<T>(buf:StringBuf, s:T, indent:String = twoSpaces):StringBuf {
		buf.add('${indent}${s}');
		return buf;
	}

	/**
	 * Adds Line Feed, `indent` and `s`.
	 * @return The given `StringBuf`.
	 */
	public static inline function lfIndentAdd<T>(buf:StringBuf, s:T, indent:String = twoSpaces):StringBuf {
		buf.add('\n${indent}${s}');
		return buf;
	}

	/**
	 * Adds `indent`, `s` and Line Feed.
	 * @param indent Defaults to 2 spaces.
	 * @return The given `StringBuf`.
	 */
	public static inline function indentAddLf<T>(buf:StringBuf, s:T, indent:String = twoSpaces):StringBuf {
		buf.add('${indent}${s}\n');
		return buf;
	}

	/**
	 * Adds each of `lines` with a preceding Line Feed.
	 * @return The given `StringBuf`.
	 */
	public static inline function lfAddLines<T>(buf:StringBuf, lines:Array<T>):StringBuf {
		for (line in lines)
			lfAdd(buf, line);
		return buf;
	}

	/**
	 * Adds each of `lines` with a succeeding Line Feed.
	 * @return The given `StringBuf`.
	 */
	public static inline function addLfLines<T>(buf:StringBuf, lines:Array<T>):StringBuf {
		for (line in lines)
			addLf(buf, line);
		return buf;
	}

	/**
	 * Adds each of `lines` with preceding Line Feed and `indent`.
	 * @param indent Defaults to 2 spaces.
	 * @return The given `StringBuf`.
	 */
	public static inline function lfIndentAddLines<T>(buf:StringBuf, lines:Array<T>, indent:String = twoSpaces):StringBuf {
		for (line in lines)
			lfIndentAdd(buf, line, indent);
		return buf;
	}

	/**
	 * Adds each of `lines` with preceding `indent` and succeeding Line Feed.
	 * @param indent Defaults to 2 spaces.
	 * @return The given `StringBuf`.
	 */
	public static inline function indentLfAddLines<T>(buf:StringBuf, lines:Array<T>, indent:String = twoSpaces):StringBuf {
		for (line in lines)
			indentAddLf(buf, line, indent);
		return buf;
	}
}
