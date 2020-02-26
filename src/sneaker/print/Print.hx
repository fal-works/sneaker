package sneaker.print;

class Print {
	/**
	 * Used only if the compilation flag `sneaker_print_buffer` is set.
	 * @see `Print.println()`
	 */
	public static var useBuffer = false;

	/**
	 * Outputs `s` followed with a new line.
	 * - On `sys` targets: Uses `Sys.println()`.
	 * - Otherwise: Uses `trace()`.
	 *
	 * Compilation flags:
	 * - If `sneaker_print_disable` is set, `println()` has no effect.
	 * - If `sneaker_print_buffer` is set and the variable `Print.useBuffer` is `true`,
	 *   it adds `s` to the buffer (`PrintBuffer.current`) instead of outputting directly.
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
	 * Outputs `s` followed with a new line.
	 * - On `sys` targets: Uses `Sys.print()`.
	 * - Otherwise: Uses `trace()`.
	 *   Note that `println()` also uses `trace()` so there is no difference between
	 *   `print()` and `println()` on non-sys targets.
	 *
	 * @see `println()` about the compilation flags.
	 */
	@:generic
	public static function print<T>(s:Null<T>):Void {
		#if sneaker_print_buffer
		if (useBuffer) {
			PrintBuffer.current.addNullable(s);
			return;
		}
		#end

		printDirect(s);
	}

	/**
	 * Outputs `s` followed with a new line.
	 *
	 * Compilation flags:
	 * - Disabled if `sneaker_print_disable` is set.
	 * - `sneaker_print_buffer` is ignored (hence "Direct").
	 */
	@:generic
	public static inline function printlnDirect<T>(s:Null<T>):Void {
		#if !sneaker_print_disable
		printlnForced(s);
		#end
	}

	/**
	 * Outputs `s`.
	 * @see `printlnDirect()` about the compilation flags.
	 */
	@:generic
	public static inline function printDirect<T>(s:Null<T>):Void {
		#if !sneaker_print_disable
		printForced(s);
		#end
	}

	/**
	 * Outputs `s` followed with a new line, ignoring the compilation flags below:
	 * - `sneaker_print_disable`
	 * - `sneaker_print_buffer`
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
	 * Outputs `s`, ignoring the compilation flags.
	 * @see `printlnForced()`
	 */
	@:generic
	public static inline function printForced<T>(s:Null<T>):Void {
		#if sys
		@:nullSafety(Off) Sys.print(s);
		#else
		trace(s);
		#end
	}

	/**
	 * Prints `s` by `println()` and also returns it.
	 */
	@:generic
	public static inline function printlnReturn<T>(s:Null<T>):Null<T> {
		println(s);
		return s;
	}

	/**
	 * Prints `s` by `println()` and then throw it.
	 */
	public static inline function printlnThrow<T>(s:Null<T>):Void {
		println(s);
		@:nullSafety(Off) throw s;
	}

	/**
	 * Calls `PrintBuffer.flushln()`, but only if the compilation flag `sneaker_print_buffer` is set
	 * and the variable `useBuffer` is `true`.
	 */
	 public static inline function flushlnBuffer():Void {
		#if sneaker_print_buffer
		if (useBuffer)
			PrintBuffer.flushln();
		#end
	}

	/**
	 * Calls `PrintBuffer.flush()`, but only if the compilation flag `sneaker_print_buffer` is set
	 * and the variable `useBuffer` is `true`.
	 */
	public static inline function flushBuffer():Void {
		#if sneaker_print_buffer
		if (useBuffer)
			PrintBuffer.flush();
		#end
	}
}
