package sneaker.macro;

#if macro
import haxe.PosInfos;
import sneaker.print.Printer;
import sneaker.macro.CompilerMessage;

/**
	Logging functions for use in macro.

	Similar to `sneaker.log.Logger`, logs are filtered according to the
	compiler flag `sneaker_macro_log_level`.
**/
class MacroLogger {
	/**
		Filtering function that returns `false` if the log should not be printed.
		At default it always returns `true` and is replaceable with any custom function.
	**/
	public static var logFilter = MacroLoggerCallbacks.defaultLogFilter;

	/**
		Function for formatting log and returns a `String` representation.
		At default it switches the format according to whether it is able to obtain
		where the macro was called.
	**/
	public static var logFormat = MacroLoggerCallbacks.defaultLogFormat;

	#if !sneaker_print_disable
	static final fatalPrefix = "[FATAL]";
	static final errorPrefix = "[ERROR]";
	static final warnPrefix = "[WARN]";
	static final infoPrefix = "[INFO]";
	static final debugPrefix = "[DEBUG]";
	#end

	/**
		Prints fatal error in a macro context.
		Also displays a compilation fatal error.
	**/
	public static function fatal(content: Dynamic, ?pos: PosInfos) {
		#if (!sneaker_print_disable && sneaker_macro_log_level >= 100)
		printLogText(fatalPrefix, content, pos);
		#end
		CompilerMessage.fatal(content);
	}

	/**
		Prints error in a macro context.
		Also displays a compilation error.
	**/
	public static function error(content: Dynamic, ?pos: PosInfos) {
		#if (!sneaker_print_disable && sneaker_macro_log_level >= 200)
		printLogText(errorPrefix, content, pos);
		#end
		CompilerMessage.error(content);
	}

	/**
		Prints warning in a macro context.
		Also displays a compilation warning.
	**/
	public static function warn(content: Dynamic, ?pos: PosInfos) {
		#if (!sneaker_print_disable && sneaker_macro_log_level >= 300)
		printLogText(warnPrefix, content, pos);
		#end
		CompilerMessage.warn(content);
	}

	/**
		Prints warning in a macro context.
		Also displays a compilation info.
	**/
	public static function info(content: Dynamic, ?pos: PosInfos) {
		#if (!sneaker_print_disable && sneaker_macro_log_level >= 400)
		printLogText(infoPrefix, content, pos);
		#end
		CompilerMessage.info(content);
	}

	/**
		Prints debug log in a macro context.
	**/
	public static function debug(content: Dynamic, ?pos: PosInfos) {
		#if (!sneaker_print_disable && sneaker_macro_log_level >= 500)
		printLogText(debugPrefix, content, pos);
		#end
	}

	#if !sneaker_print_disable
	/**
		Prints any log text with `prefix` in a macro context.
	**/
	static function printLogText(
		prefix: String,
		content: Dynamic,
		?executingPosition: PosInfos
	): Void {
		final localClass = Context.getLocalClass();
		final localClassPath = if (localClass != null) localClass.toString() else null;

		if (!logFilter(localClassPath, executingPosition)) return;

		Printer.println(logFormat(
			prefix,
			content,
			localClassPath,
			executingPosition
		));
	}
	#end
}
#end
