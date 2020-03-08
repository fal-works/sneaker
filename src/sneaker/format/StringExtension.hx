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
		@return Sub-string after the last occurrence of dot (`.`).
	**/
	public static inline function sliceAfterLastDot(s: String): String {
		return s.substr(s.lastIndexOf(dot) + 1);
	}

	/**
		@return Sub-string after the last occurrence of slash (`/`).
	**/
	public static inline function sliceAfterLastSlash(s: String): String {
		return s.substr(s.lastIndexOf(slash) + 1);
	}

	/**
		@return Sub-string before the last occurrence of dot (`.`).
	**/
	public static inline function sliceBeforeLastDot(s: String): String {
		return s.substr(0, s.lastIndexOf(dot));
	}

	/**
		@return Sub-string before the last occurrence of slash (`/`).
	**/
	public static inline function sliceBeforeLastSlash(s: String): String {
		return s.substr(0, s.lastIndexOf(slash));
	}
}
