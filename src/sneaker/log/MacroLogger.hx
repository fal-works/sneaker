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
		@return Current file and character position, e.g. "src/Main.hx:42".
	**/
	@:noUsing
	public static inline function getFilePosition(): String {
		final position = Context.getPosInfos(Context.currentPos());
		return '${position.file}:${position.min}';
	}

	/**
		Adds current file and character position, e.g. "src/Main.hx:42".
		@return `buffer`
	**/
	public static inline function addFilePosition<T: StringBuffer>(buffer: T): T {
		final position = Context.getPosInfos(Context.currentPos());
		buffer.add(position.file);
		buffer.addChar(":".code);
		buffer.add(position.min);

		return buffer;
	}

	/**
		Adds prefix and file position, e.g. `[PREFIX] src/Main.hx:42`.
		@return `buffer`
	**/
	public static inline function addPrefixFilePosition<T: StringBuffer>(
		buffer: T,
		prefix: String
	): T {
		buffer.addRightPadded(prefix, " ".code, LogFormats.alignmentPosition);
		buffer.addFilePosition();

		return buffer;
	}
}
#end
