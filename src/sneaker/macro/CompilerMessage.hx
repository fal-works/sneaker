package sneaker.macro;

#if macro
import haxe.macro.Expr.Position;

/**
	Functions for displaying compilation messages in a macro context.

	Similar to `MacroLogger` class, each function respects the compiler flag
	`sneaker_macro_message_level`.

	These functions are not affected by the compiler flag `sneaker_print_disable`.
**/
class CompilerMessage {
	/**
		Displays a compilation fatal error at `position`.
	**/
	public static function fatal(message: String, ?position: Position): Void {
		#if !display
		if (CompilerFlags.macroMessageLevel.get() >= 100)
			Context.fatalError(
				message,
				if (position != null) position else PositionStack.peek()
			);
		#end
	}

	/**
		Displays a compilation error at `position`.
	**/
	public static function error(message: String, ?position: Position): Void {
		#if !display
		if (CompilerFlags.macroMessageLevel.get() >= 200)
			Context.error(
				message,
				if (position != null) position else PositionStack.peek()
			);
		#end
	}

	/**
		Displays a compilation warning at `position`.
	**/
	public static function warn(message: String, ?position: Position): Void {
		#if !display
		if (CompilerFlags.macroMessageLevel.get() >= 300)
			Context.warning(
				message,
				if (position != null) position else PositionStack.peek()
			);
		#end
	}

	/**
		Displays a compilation info at `position`.
	**/
	public static function info(message: String, ?position: Position): Void {
		#if !display
		if (CompilerFlags.macroMessageLevel.get() >= 400)
			Context.info(
				message,
				if (position != null) position else PositionStack.peek()
			);
		#end
	}
}
#end
