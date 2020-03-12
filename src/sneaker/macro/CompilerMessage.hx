package sneaker.macro;

#if macro
/**
	Functions for displaying compilation messages in a macro context.

	Similar to `MacroLogger` class, each function respects the compiler flag
	`sneaker_macro_message_level`.
**/
class CompilerMessage {
	/**
		Displays a compilation fatal error at the position where macro was called.
	**/
	public static inline function fatal(message: String): Void {
		#if (sneaker_macro_message_level >= 100)
		Context.fatalError(message, Context.currentPos());
		#end
	}

	/**
		Displays a compilation error at the position where macro was called.
	**/
	public static inline function error(message: String): Void {
		#if (sneaker_macro_message_level >= 200)
		Context.error(message, Context.currentPos());
		#end
	}

	/**
		Displays a compilation warning at the position where macro was called.
	**/
	public static inline function warn(message: String): Void {
		#if (sneaker_macro_message_level >= 300)
		Context.warning(message, Context.currentPos());
		#end
	}

	/**
		Displays a compilation info at the position where macro was called.
	**/
	public static inline function info(message: String): Void {
		#if (sneaker_macro_message_level >= 400)
		Context.info(message, Context.currentPos());
		#end
	}
}
#end
