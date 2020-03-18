package sneaker.macro;

#if macro
/**
	Functions for displaying compilation messages in a macro context.

	Similar to `MacroLogger` class, each function respects the compiler flag
	`sneaker_macro_message_level`.

	These functions are not affected by the compiler flag `sneaker_print_disable`.
**/
class CompilerMessage {
	/**
		Displays a compilation fatal error at the position most recently saved in `PositionStack`.
	**/
	public static inline function fatal(message: String): Void {
		if (CompilerFlags.macroMessageLevel.get() >= 100)
			Context.fatalError(message, PositionStack.peek());
	}

	/**
		Displays a compilation error at the position most recently saved in `PositionStack`.
	**/
	public static inline function error(message: String): Void {
		if (CompilerFlags.macroMessageLevel.get() >= 200)
			Context.error(message, PositionStack.peek());
	}

	/**
		Displays a compilation warning at the position most recently saved in `PositionStack`.
	**/
	public static inline function warn(message: String): Void {
		if (CompilerFlags.macroMessageLevel.get() >= 300)
			Context.warning(message, PositionStack.peek());
	}

	/**
		Displays a compilation info at the position most recently saved in `PositionStack`.
	**/
	public static inline function info(message: String): Void {
		if (CompilerFlags.macroMessageLevel.get() >= 400)
			Context.info(message, PositionStack.peek());
	}
}
#end
