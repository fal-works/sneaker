package sneaker.log;

class Print {
	/**
	 * Outputs `s`, followed with a new line.
	 * - On `sys` targets: Calls `Sys.println()`.
	 * - Otherwise: Calls `trace()`.
	 *
	 * Compilation flag:
	 * - Disabled if `sneaker_print_disable` is set.
	 */
	@:generic
	public static function println<T>(s:Null<T>):Void {
		#if !sneaker_print_disable
		#if sys
		@:nullSafety(Off) Sys.println(s);
		#else
		trace(s);
		#end
		#end
	}

	/**
	 * Prints `s` and also returns it.
	 */
	@:generic
	public static inline function printlnReturn<T>(s:Null<T>):Null<T> {
		println(s);
		return s;
	}

	/**
	 * Prints `s` and then throw it.
	 */
	public static inline function printlnThrow<T>(s:Null<T>):Void {
		println(s);
		@:nullSafety(Off) throw s;
	}
}
