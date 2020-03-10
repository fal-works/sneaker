package sneaker.format;

import haxe.ds.Option;

class StringExtension {
	static final dot = ".";
	static final slash = "/";

	/**
		Converts `Null<T>` to `Option<String>`.
		@return `None` if null, `Some(s)` if not null.
	**/
	public static inline function toOptionalString<T>(s: Null<T>): Option<String> {
		return s != null ? Some(Std.string(s)) : None;
	}

	/**
		@return The first index of dot (`.`).
	**/
	public static inline function indexOfDot(s: String, ?startIndex: Int): Int
		return s.indexOf(dot, startIndex);

	/**
		@return The first index of slash (`/`).
	**/
	public static inline function indexOfSlash(s: String, ?startIndex: Int): Int
		return s.indexOf(slash, startIndex);

	/**
		@return The last index of dot (`.`).
	**/
	public static inline function lastIndexOfDot(s: String, ?startIndex: Int): Int
		return s.lastIndexOf(dot, startIndex);

	/**
		@return The last index of slash (`/`).
	**/
	public static inline function lastIndexOfSlash(s: String, ?startIndex: Int): Int
		return s.lastIndexOf(slash, startIndex);

	/**
		@return Sub-string after the last occurrence of dot (`.`).
	**/
	public static inline function sliceAfterLastDot(s: String): String
		return s.substr(lastIndexOfDot(s) + 1);

	/**
		@return Sub-string after the last occurrence of slash (`/`).
	**/
	public static inline function sliceAfterLastSlash(s: String): String
		return s.substr(lastIndexOfSlash(s) + 1);

	/**
		@return Sub-string before the last occurrence of dot (`.`).
	**/
	public static inline function sliceBeforeLastDot(s: String): String
		return s.substr(0, lastIndexOfDot(s));

	/**
		@return Sub-string before the last occurrence of slash (`/`).
	**/
	public static inline function sliceBeforeLastSlash(s: String): String
		return s.substr(0, lastIndexOfSlash(s));
}
