package sneaker.log;

class Print {
	/**
	 * Prints `s` to the standard output, followed with a new line.
	 * - On `sys` targets: Calls `Sys.println()`.
	 * - Otherwise: Calls `trace()`.
	 */
	@:generic
	public static function println<T>(s:Null<T>):Void {
		#if !no_traces
		#if sys
		@:nullSafety(Off) Sys.println(s);
		#else
		trace(s);
		#end
		#end
	}

	/**
	 * Prints `message` and also returns it.
	 */
	@:generic
	public static inline function printlnReturn<T>(message:Null<T>):Null<T> {
		println(message);
		return message;
	}

	/**
	 * Prints `message` and then throw it.
	 */
	public static inline function printlnThrow<T>(message:Null<T>):Void {
		println(message);
		@:nullSafety(Off) throw message;
	}
}
