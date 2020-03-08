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
		buffer.addChar(":".code);
		buffer.add(position.min);

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
}
#end
