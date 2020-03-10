package sneaker.macro;

#if macro
/**
	Functions for displaying compilation messages in a macro context.
**/
class CompilerMessage {
	/**
		Displays a compilation fatal error at the position where macro was called.
	**/
	public static inline function fatal(message: String): Void
		Context.fatalError(message, Context.currentPos());

	/**
		Displays a compilation error at the position where macro was called.
	**/
	public static inline function error(message: String): Void
		Context.error(message, Context.currentPos());

	/**
		Displays a compilation warning at the position where macro was called.
	**/
	public static inline function warn(message: String): Void
		Context.warning(message, Context.currentPos());

	/**
		Displays a compilation info at the position where macro was called.
	**/
	public static inline function info(message: String): Void
		Context.info(message, Context.currentPos());
}
#end
