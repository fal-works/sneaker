package sneaker.macro;

#if macro
using sneaker.format.PosInfosExtension;
using sneaker.macro.StringBufferLogExtension;
using sneaker.format.StringExtension;

import haxe.PosInfos;
import sneaker.string_buffer.StringBuffer;

/**
	Functions used in `MacroLogger` class.
**/
class MacroLoggerCallbacks {
	/**
		Default function for `MacroLogger.logFilter`.
	**/
	public static var defaultLogFilter = function(
			localClassPath: Null<String>,
			?macroPosition: PosInfos
	): Bool return true;

	/**
		Default function for `MacroLogger.logFormat`.
	**/
	public static var defaultLogFormat = function(
			prefix: String,
			content: Dynamic,
			localClassPath: Null<String>,
			?macroPosition: PosInfos
	): String {
		final buffer = new StringBuffer();
		buffer.addPrefix(prefix);
		if (localClassPath != null) {
			buffer.addFilePath();
			buffer.add(pipe);
			buffer.add(localClassPath.sliceAfterLastDot());
			buffer.add(pipe);
			buffer.add(content);
		} else {
			buffer.add(content);
			buffer.add(openingParen);
			buffer.add(macroPosition.formatClassMethod());
			buffer.add(closingParen);
		}
		return buffer.toString();
	}

	static final pipe = " | ";
	static final openingParen = " (";
	static final closingParen = ")";
}
#end
