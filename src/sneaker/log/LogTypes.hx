package sneaker.log;

/**
 * Collection of standard log types.
 */
@:nullSafety(Strict)
class LogTypes {
	public static var Fatal = new LogType("[FATAL]");
	public static var Error = new LogType("[ERROR]");
	public static var Warn = new LogType("[WARN] ");
	public static var Info = new LogType("[INFO] ");
	public static var Debug = new LogType("[DEBUG]");

	/**
	 * Recreate all types in `LogTypes`.
	 *
	 * This can be used e.g. for reflecting changes of static variables in `LogType`.
	 */
	public static function reset() {
		Fatal = new LogType("[FATAL]");
		Error = new LogType("[ERROR]");
		Warn = new LogType("[WARN] ");
		Info = new LogType("[INFO] ");
		Debug = new LogType("[DEBUG]");
	}
}
