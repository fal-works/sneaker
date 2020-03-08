package sneaker.log;

#if macro
import haxe.macro.Context;
import sneaker.print.Printer;
import sneaker.log.LogFormats;
import sneaker.string_buffer.StringBuffer;

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
		Creates a function that formats and prints a log message.

		e.g. `[PREFIX] src/Main.hx:42 | Got error!`
	**/
	@:noUsing
	public static function createLogFunction(
		prefix: String
	): (content: Null<Dynamic>) -> Void {
		return function(content) {
			final buffer = new StringBuffer();

			buffer.add(LogFormats.padPrefixString(prefix));
			addFilePosition(buffer);
			buffer.add(separator);
			buffer.addNullable(content);

			final logText = buffer.toString();
			Printer.println(logText);
		};
	}

	static final separator = " | ";
}
#end
