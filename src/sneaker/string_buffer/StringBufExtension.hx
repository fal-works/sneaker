package sneaker.string_buffer;

class StringBufExtension {
	static inline final lineFeedCode = 10;
	static inline final twoSpaces = "  ";

	/**
	 * Adds `s`. Workaround for errors in `@:nullSafety` mode.
	 * @return The given `StringBuf`.
	 */
	public static inline function addNullable<T>(buf: StringBuf, s: Null<T>): StringBuf {
		@:nullSafety(Off) buf.add(s);
		return buf;
	}

	/**
	 * Adds Line Feed (i.e. "\n").
	 * @return The given `StringBuf`.
	 */
	public static inline function lf(buf: StringBuf): StringBuf {
		buf.addChar(lineFeedCode);
		return buf;
	}

	/**
	 * Adds Line Feed and `s`.
	 * @return The given `StringBuf`.
	 */
	public static inline function lfAdd<T>(buf: StringBuf, s: Null<T>): StringBuf {
		#if sys
		lf(buf);
		addNullable(buf, s);
		#else
		@:nullSafety(Off) buf.add('\n${s}');
		#end
		return buf;
	}

	/**
	 * Adds `s` and Line Feed.
	 * @return The given `StringBuf`.
	 */
	public static inline function addLf<T>(buf: StringBuf, s: Null<T>): StringBuf {
		#if sys
		addNullable(buf, s);
		lf(buf);
		#else
		@:nullSafety(Off) buf.add('${s}\n');
		#end
		return buf;
	}

	/**
	 * Adds `indent` and `s`.
	 * @param indent Defaults to 2 spaces.
	 * @return The given `StringBuf`.
	 */
	public static inline function indentAdd<T>(
		buf: StringBuf,
		s: Null<T>,
		indent: String = twoSpaces
	): StringBuf {
		@:nullSafety(Off) buf.add('${indent}${s}');
		return buf;
	}

	/**
	 * Adds Line Feed, `indent` and `s`.
	 * @return The given `StringBuf`.
	 */
	public static inline function lfIndentAdd<T>(
		buf: StringBuf,
		s: Null<T>,
		indent: String = twoSpaces
	): StringBuf {
		@:nullSafety(Off) buf.add('\n${indent}${s}');
		return buf;
	}

	/**
	 * Adds `indent`, `s` and Line Feed.
	 * @param indent Defaults to 2 spaces.
	 * @return The given `StringBuf`.
	 */
	public static inline function indentAddLf<T>(
		buf: StringBuf,
		s: Null<T>,
		indent: String = twoSpaces
	): StringBuf {
		@:nullSafety(Off) buf.add('${indent}${s}\n');
		return buf;
	}

	/**
	 * Adds each of `lines` with a preceding Line Feed.
	 * @return The given `StringBuf`.
	 */
	public static inline function lfAddLines<T>(
		buf: StringBuf,
		lines: Array<Null<T>>
	): StringBuf {
		for (line in lines) lfAdd(buf, line);
		return buf;
	}

	/**
	 * Adds each of `lines` with a succeeding Line Feed.
	 * @return The given `StringBuf`.
	 */
	public static inline function addLfLines<T>(
		buf: StringBuf,
		lines: Array<Null<T>>
	): StringBuf {
		for (line in lines) addLf(buf, line);
		return buf;
	}

	/**
	 * Adds each of `lines` with preceding Line Feed and `indent`.
	 * @param indent Defaults to 2 spaces.
	 * @return The given `StringBuf`.
	 */
	public static inline function lfIndentAddLines<T>(
		buf: StringBuf,
		lines: Array<Null<T>>,
		indent: String = twoSpaces
	): StringBuf {
		for (line in lines) lfIndentAdd(buf, line, indent);
		return buf;
	}

	/**
	 * Adds each of `lines` with preceding `indent` and succeeding Line Feed.
	 * @param indent Defaults to 2 spaces.
	 * @return The given `StringBuf`.
	 */
	public static inline function indentLfAddLines<T>(
		buf: StringBuf,
		lines: Array<Null<T>>,
		indent: String = twoSpaces
	): StringBuf {
		for (line in lines) indentAddLf(buf, line, indent);
		return buf;
	}
}
