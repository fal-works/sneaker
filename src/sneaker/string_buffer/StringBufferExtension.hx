package sneaker.string_buffer;

import sneaker.string_buffer.interfaces.StringBuffer;

class StringBufferExtension {
	static extern inline final lineFeedCode = "\n".code;
	static inline final twoSpaces = "  ";

	/**
		Adds `s`. Workaround for errors in `@:nullSafety` mode.
		@return The given `StringBuf`.
	**/
	public static inline function addNullable<T>(buf: StringBuffer, s: Null<T>): Void {
		@:nullSafety(Off) buf.add(s);
	}

	/**
		Adds Line Feed (i.e. "\n").
		@return The given `StringBuf`.
	**/
	public static inline function lf(buf: StringBuffer): Void {
		buf.addChar(lineFeedCode);
	}

	/**
		Adds Line Feed and `s`.
		@return The given `StringBuf`.
	**/
	public static inline function lfAdd<T>(buf: StringBuffer, s: Null<T>): Void {
		#if sys
		lf(buf);
		addNullable(buf, s);
		#else
		@:nullSafety(Off) buf.add('\n${s}');
		#end
	}

	/**
		Adds `s` and Line Feed.
		@return The given `StringBuf`.
	**/
	public static inline function addLf<T>(buf: StringBuffer, s: Null<T>): Void {
		#if sys
		addNullable(buf, s);
		lf(buf);
		#else
		@:nullSafety(Off) buf.add('${s}\n');
		#end
	}

	/**
		Adds `indent` and `s`.
		@param indent Defaults to 2 spaces.
		@return The given `StringBuf`.
	**/
	public static inline function indentAdd<T>(
		buf: StringBuffer,
		s: Null<T>,
		indent: String = twoSpaces
	): Void {
		@:nullSafety(Off) buf.add('${indent}${s}');
	}

	/**
		Adds Line Feed, `indent` and `s`.
		@return The given `StringBuf`.
	**/
	public static inline function lfIndentAdd<T>(
		buf: StringBuffer,
		s: Null<T>,
		indent: String = twoSpaces
	): Void {
		@:nullSafety(Off) buf.add('\n${indent}${s}');
	}

	/**
		Adds `indent`, `s` and Line Feed.
		@param indent Defaults to 2 spaces.
		@return The given `StringBuf`.
	**/
	public static inline function indentAddLf<T>(
		buf: StringBuffer,
		s: Null<T>,
		indent: String = twoSpaces
	): Void {
		@:nullSafety(Off) buf.add('${indent}${s}\n');
	}

	/**
		Adds `s` with right-padding.
	**/
	public static inline function addRightPadded<T: StringBuffer, S>(
		buf: T,
		s: Null<S>,
		padCharacterCode: Int,
		length: Int
	): T {
		@:nullSafety(Off) final str = Std.string(s);
		var currentLength = str.length;
		buf.add(str);

		while (currentLength < length) {
			buf.addChar(padCharacterCode);
			currentLength += 1;
		}

		return buf;
	}

	/**
		Adds padding until the total length of `buf` is at least `totalLength`.
	**/
	public static inline function padUntil<T: StringBuffer, S>(
		buf: T,
		padCharacterCode: Int,
		totalLength: Int
	): T {
		var currentLength = buf.length;

		while (currentLength < totalLength) {
			buf.addChar(padCharacterCode);
			currentLength += 1;
		}

		return buf;
	}

	/**
		Adds padding until the total length of `buf` is at least `totalLength`.
	**/
	public static inline function addTabLike<T: StringBuffer, S>(buf: T, tabSize: Int): T {
		var currentLength = buf.length;

		final alignmentPosition = Math.ceil(currentLength / tabSize) * tabSize;
		padUntil(buf, " ".code, alignmentPosition);

		return buf;
	}

	/**
		Adds each of `lines` with a preceding Line Feed.
		@return The given `StringBuf`.
	**/
	public static inline function lfAddLines<T>(
		buf: StringBuffer,
		lines: Array<Null<T>>
	): Void {
		for (line in lines) lfAdd(buf, line);
	}

	/**
		Adds each of `lines` with a succeeding Line Feed.
		@return The given `StringBuf`.
	**/
	public static inline function addLfLines<T>(
		buf: StringBuffer,
		lines: Array<Null<T>>
	): Void {
		for (line in lines) addLf(buf, line);
	}

	/**
		Adds each of `lines` with preceding Line Feed and `indent`.
		@param indent Defaults to 2 spaces.
		@return The given `StringBuf`.
	**/
	public static inline function lfIndentAddLines<T>(
		buf: StringBuffer,
		lines: Array<Null<T>>,
		indent: String = twoSpaces
	): Void {
		for (line in lines) lfIndentAdd(buf, line, indent);
	}

	/**
		Adds each of `lines` with preceding `indent` and succeeding Line Feed.
		@param indent Defaults to 2 spaces.
		@return The given `StringBuf`.
	**/
	public static inline function indentLfAddLines<T>(
		buf: StringBuffer,
		lines: Array<Null<T>>,
		indent: String = twoSpaces
	): Void {
		for (line in lines) indentAddLf(buf, line, indent);
	}
}
