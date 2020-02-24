package sneaker.format;

@:nullSafety(Strict)
class StringExtension {
	@:nullSafety(Off)
	public static inline function formatNullable(s:Null<Dynamic>):String {
		return cast s;
	}

	public static inline function sliceAfterLastDot(s:String):String {
		return s.substr(s.lastIndexOf(".") + 1);
	}
}
