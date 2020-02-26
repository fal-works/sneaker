package sneaker.log;

class Print {
	/**
	 * Used only if the compilation flag `sneaker_print_buffer` is set.
	 *
	 * If set to `true`, `println()` adds the string to the buffer (`PrintBuffer.current`)
	 * instead of outputting directly.
	 */
	public static var useBuffer = false;

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
		#if sneaker_print_buffer
		if (useBuffer) {
			PrintBuffer.current.addLf(s);
			return;
		}
		#end

		printlnDirect(s);
	}

	/**
	 * Outputs `s` followed with a new line,
	 * ignoring the compilation flag `sneaker_print_disable`.
	 */
	@:generic
	public static inline function printlnDirect<T>(s:Null<T>):Void {
		#if !sneaker_print_disable
		printlnForced(s);
		#end
	}

	/**
	 * Outputs `s` followed with a new line,
	 * ignoring the compilation flag `sneaker_print_disable`.
	 */
	@:generic
	public static inline function printlnForced<T>(s:Null<T>):Void {
		#if sys
		@:nullSafety(Off) Sys.println(s);
		#else
		trace(s);
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
