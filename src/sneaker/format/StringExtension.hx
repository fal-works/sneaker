package sneaker.format;

import haxe.ds.Option;

@:nullSafety(Strict)
class StringExtension {
	static final dot = ".";
	static final slash = "/";

	@:nullSafety(Off)
	public static inline function formatNullable(s:Null<Dynamic>):String {
		return cast s;
	}

	public static inline function toNullableString(s:Null<Dynamic>):Null<String> {
		return s;
	}

	public static inline function toOptionalString(s:Null<Dynamic>):Option<String> {
		return s != null ? Some(s) : None;
	}

	public static inline function sliceAfterLastDot(s:String):String {
		return s.substr(s.lastIndexOf(dot) + 1);
	}

	public static inline function sliceAfterLastSlash(s:String):String {
		return s.substr(s.lastIndexOf(slash) + 1);
	}
}
