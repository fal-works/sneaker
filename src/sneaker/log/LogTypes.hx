package sneaker.log;

/**
	Collection of standard log types.
**/
class LogTypes {
	static final prefixes = {
		fatal: "[FATAL] ",
		error: "[ERROR] ",
		warn: "[WARN]  ",
		info: "[INFO]  ",
		debug: "[DEBUG] "
	};

	public static var fatal = new LogType(prefixes.fatal);
	public static var error = new LogType(prefixes.error);
	public static var warn = new LogType(prefixes.warn);
	public static var info = new LogType(prefixes.info);
	public static var debug = new LogType(prefixes.debug);

	/**
		Recreate all types in `LogTypes`.

		This can be used e.g. for reflecting changes of static variables in `LogType`.
	**/
	public static function reset() {
		fatal = new LogType(prefixes.fatal);
		error = new LogType(prefixes.error);
		warn = new LogType(prefixes.warn);
		info = new LogType(prefixes.info);
		debug = new LogType(prefixes.debug);
	}
}
