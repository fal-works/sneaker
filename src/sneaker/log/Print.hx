package sneaker.log;

using sneaker.format.StringExtension;

@:nullSafety(Strict)
class Print {
	/**
	 * Prints `s` to the standard output, followed with a new line.
	 */
	public static inline function println<T>(s:Null<T>):Void {
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
	public static inline function printlnReturn<T>(message:Null<T>):Null<T> {
		println(message);
		return message;
	}

	/**
	 * Prints `message` and then throw it.
	 */
	public static inline function printlnThrow<T>(message:Null<T>):Void {
		println(message);
		throw message.formatNullable();
	}
}
