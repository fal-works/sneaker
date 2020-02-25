package sneaker.format;

import haxe.ds.Option;

@:nullSafety(Strict)
class StringExtension {
	static final dot = ".";
	static final slash = "/";

	/**
	 * Workaround for errors in `@:nullSafety` mode.
	 * @return `String` representation of `s`.
	 */
	@:nullSafety(Off)
	public static inline function formatNullable<T>(s:Null<T>):String {
		return Std.string(cast s);
	}

	/**
	 * Casts `Null<T>` to `Null<String>`.
	 */
	public static inline function toNullableString<T>(s:Null<T>):Null<String> {
		return cast s;
	}

	/**
	 * Converts `Null<T>` to `Option<String>`.
	 * @return `None` if null, `Some(s)` if not null.
	 */
	public static inline function toOptionalString<T>(s:Null<T>):Option<String> {
		return s != null ? Some(formatNullable(s)) : None;
	}

	/**
	 * @return Sub-string after the last occurrence of dot (`.`).
	 */
	public static inline function sliceAfterLastDot(s:String):String {
		return s.substr(s.lastIndexOf(dot) + 1);
	}

	/**
	 * @return Sub-string after the last occurrence of slash (`/`).
	 */
	public static inline function sliceAfterLastSlash(s:String):String {
		return s.substr(s.lastIndexOf(slash) + 1);
	}
}
