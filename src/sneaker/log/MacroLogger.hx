package sneaker.log;

#if macro
import haxe.macro.Context;
import sneaker.log.LogFormats;
import sneaker.string_buffer.StringBuffer;

using sneaker.string_buffer.StringBufferExtension;
using sneaker.log.MacroLogger;

/**
	Functions for logging in a macro context.
**/
class MacroLogger {
	/**
		@return Current file path, e.g. "src/Main.hx".
	**/
	@:noUsing
	public static inline function getFilePath(): String {
		final position = Context.getPosInfos(Context.currentPos());
		return '${position.file}';
	}

	/**
		Adds current file path, e.g. "src/Main.hx".
		@return `buffer`
	**/
	public static inline function addFilePath<T: StringBuffer>(buffer: T): T {
		final position = Context.getPosInfos(Context.currentPos());
		buffer.add(position.file);

		return buffer;
	}

	/**
		Adds prefix and file path, e.g. `[PREFIX] src/Main.hx`.
		@return `buffer`
	**/
	public static inline function addPrefixFilePath<T: StringBuffer>(
		buffer: T,
		prefix: String
	): T {
		buffer.addRightPadded(prefix, " ".code, LogFormats.alignmentPosition);
		buffer.addFilePath();

		return buffer;
	}

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
