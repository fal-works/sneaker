package sneaker.print;

class Print {
	/**
	 * The buffer used when `Print.useBuffer` is `true`.
	 * @see `Print.println()`
	 */
	public static final buffer = new PrintBuffer();

	/**
	 * If `true`, `Print.println()` and `Print.print()` use `Print.buffer`.
	 * @see `Print.println()`
	 */
	public static var useBuffer = false;

	/**
	 * The value that was most recently printed.
	 *
	 * Compilation flag:
	 * - If `sneaker_print_last_disable` is set, it is always `null`.
	 */
	#if !sneaker_print_last_disable
	public static var lastPrinted(default, null): Null<Dynamic> = null;
	#else
	public static inline final lastPrinted: Null<Dynamic> = null;
	#end

	/**
	 * The value that was most recently buffered via `Print.println()` or `Print.print()`.
	 * It does not reflect values that are added directly to `Print.buffer`.
	 *
	 * Compilation flag:
	 * - If `sneaker_print_last_disable` is set, it is always `null`.
	 */
	#if !sneaker_print_last_disable
	public static var lastBuffered(default, null): Null<Dynamic> = null;
	#else
	public static inline final lastBuffered: Null<Dynamic> = null;
	#end

	/**
	 * Outputs `s` followed with a new line.
	 * - On `sys` targets: Uses `Sys.println()`.
	 * - Otherwise: Uses `trace()`.
	 *
	 * If `Print.useBuffer` is `true`, it adds the given `s` to the buffer (`Print.buffer.current`)
	 * instead of outputting directly, and the result is printed if the buffer is full
	 * or when you call `Print.buffer.flush()`.
	 *
	 * Compilation flags:
	 * - If `sneaker_print_disable` is set, `println()` has no effect.
	 * - If `sneaker_print_buffer_disable` is set, `Print.useBuffer` is ignored.
	 */
	@:generic
	public static function println<T>(s: Null<T>): Void {
		#if !sneaker_print_disable
			#if !sneaker_print_buffer_disable
			if (useBuffer) {
				#if !sneaker_print_last_disable
				lastBuffered = s;
				#end

				buffer.current.addLf(s);
				return;
			}
			#end

		printlnDirect(s);
		#end
	}

	/**
	 * Outputs `s` without a new line.
	 *
	 * On non-sys targets, this uses `trace()` as well as `Print.println()` does, so
	 * note that it works inconsistently among targets and also depending on whether
	 * you use the buffer.
	 *
	 * @see `println()` for other details.
	 */
	@:generic
	public static function print<T>(s: Null<T>): Void {
		#if !sneaker_print_disable
			#if !sneaker_print_buffer_disable
			if (useBuffer) {
				#if !sneaker_print_last_disable
				lastBuffered = s;
				#end

				buffer.current.addNullable(s);
				return;
			}
			#end

		printDirect(s);
		#end
	}

	/**
	 * Outputs `s` followed with a new line,
	 * ignoring the variable `Print.useBuffer` (hence "Direct").
	 *
	 * Compilation flag:
	 * - Disabled if `sneaker_print_disable` is set.
	 */
	@:generic
	public static inline function printlnDirect<T>(s: Null<T>): Void {
		#if !sneaker_print_disable
		printlnForced(s);
		#end
	}

	/**
	 * Outputs `s` without a new line.
	 * @see `printlnDirect()`.
	 */
	@:generic
	public static inline function printDirect<T>(s: Null<T>): Void {
		#if !sneaker_print_disable
		printForced(s);
		#end
	}

	/**
	 * Outputs `s` followed with a new line, ignoring the compilation flag `sneaker_print_disable`
	 * and the variable `Print.useBuffer`.
	 */
	@:generic
	public static inline function printlnForced<T>(s: Null<T>): Void {
		#if !sneaker_print_last_disable
		lastPrinted = s;
		#end

		#if sys
		@:nullSafety(Off) Sys.println(s);
		#else
		trace(s);
		#end
	}

	/**
	 * Outputs `s` without a new line, ignoring the compilation flag `sneaker_print_disable`
	 * and the variable `Print.useBuffer`.
	 */
	@:generic
	public static inline function printForced<T>(s: Null<T>): Void {
		#if !sneaker_print_last_disable
		lastPrinted = s;
		#end

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
	public static inline function printlnReturn<T>(s: Null<T>): Null<T> {
		println(s);
		return s;
	}

	/**
	 * Prints `s` by `println()` and then throw it.
	 */
	public static inline function printlnThrow<T>(s: Null<T>): Void {
		println(s);
		@:nullSafety(Off) throw s;
	}
}
