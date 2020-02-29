package sneaker.log;

/**
	Collection of standard log types.
**/
class LogTypes {
	public static var fatal = new LogType("[FATAL] ");
	public static var error = new LogType("[ERROR] ");
	public static var warn = new LogType("[WARN]  ");
	public static var info = new LogType("[INFO]  ");
	public static var debug = new LogType("[DEBUG] ");

	/**
		Recreate all types in `LogTypes`.

		This can be used e.g. for reflecting changes of static variables in `LogType`.
	**/
	public static function reset() {
		fatal = new LogType("[FATAL] ");
		error = new LogType("[ERROR] ");
		warn = new LogType("[WARN]  ");
		info = new LogType("[INFO]  ");
		debug = new LogType("[DEBUG] ");
	}
}
