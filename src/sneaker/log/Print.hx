package sneaker.log;

using sneaker.format.StringExtension;

@:nullSafety(Strict)
class Print {
	/**
	 * Prints `s` to the standard output, followed with a new line.
	 *
	 * Unlike `Log.logSimple()`, this accepts any `Dynamic` values including `null`.
	 */
	public static inline function println(s:Null<Dynamic>):Void {
		#if (sys && !no_traces)
		#if (!haxe4 && android)
		trace(s);
		#else
		@:nullSafety(Off) Sys.println(s);
		#end
		#end
	}

	/**
	 * Prints `s` to the standard output, followed with a new line.
	 *
	 * Unlike `println()`, this accepts only `String` values (then internally calls `println()`).
	 */
	public static function printlnString(s:String):Void {
		println(s);
	}

	/**
	 * Prints `message` and also returns it.
	 */
	public static inline function printlnReturn(message:Null<Dynamic>):Null<Dynamic> {
		println(message);
		return message;
	}

	/**
	 * Prints `message` and then throw it.
	 */
	public static inline function printlnThrow(message:Null<Dynamic>):Void {
		println(message);
		throw message.formatNullable();
	}
}
