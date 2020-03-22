package sneaker.macro.extensions;

#if macro
using sneaker.string_buffer.StringBufferExtension;

import sneaker.log.LogFormats;
import sneaker.string_buffer.StringBuffer;

class StringBufferLogExtension {
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
		Add `prefix` right-padded according to `sneaker.log.LogFormats.alignmentPosition`.
		@return `buffer`
	**/
	public static inline function addPrefix<T: StringBuffer>(
		buffer: T,
		prefix: String
	): T {
		buffer.addRightPadded(prefix, " ".code, LogFormats.alignmentPosition);
		return buffer;
	}

	/**
		Adds prefix and file path, e.g. `[PREFIX] src/Main.hx`.
		The file path is left-aligned at `sneaker.log.LogFormats.alignmentPosition`.
		@return `buffer`
	**/
	public static inline function addPrefixFilePath<T: StringBuffer>(
		buffer: T,
		prefix: String
	): T {
		addPrefix(buffer, prefix);
		addFilePath(buffer);

		return buffer;
	}
}
#end
