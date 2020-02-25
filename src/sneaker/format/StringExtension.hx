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
	public static inline function formatNullable(s:Null<Dynamic>):String {
		return cast s;
	}

	/**
	 * Casts `Null<Dynamic>` to `Null<String>`.
	 */
	public static inline function toNullableString(s:Null<Dynamic>):Null<String> {
		return s;
	}

	/**
	 * Converts `Null<Dynamic>` to `Option<String>`.
	 * @return `None` if null, `Some(s)` if not null.
	 */
	public static inline function toOptionalString(s:Null<Dynamic>):Option<String> {
		return s != null ? Some(s) : None;
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
