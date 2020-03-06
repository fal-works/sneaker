package sneaker.log;

/**
	Collection of standard built-in log types.
**/
class LogTypes {
	static final constants: BuiltInConstants = {
		fatal: {
			prefix: "[FATAL] ",
			level: 100
		},
		error: {
			prefix: "[ERROR] ",
			level: 200
		},
		warn: {
			prefix: "[WARN]  ",
			level: 300
		},
		info: {
			prefix: "[INFO]  ",
			level: 400
		},
		debug: {
			prefix: "[DEBUG] ",
			level: 500
		}
	};

	public static var fatal = constants.fatal.build();
	public static var error = constants.error.build();
	public static var warn = constants.warn.build();
	public static var info = constants.info.build();
	public static var debug = constants.debug.build();

	/**
		Recreate all types in `LogTypes`.

		This can be used e.g. for reflecting changes of static variables in `LogType`.
	**/
	public static function reset() {
		fatal = constants.fatal.build();
		error = constants.error.build();
		warn = constants.warn.build();
		info = constants.info.build();
		debug = constants.debug.build();
	}
}

/**
	Structure just for type inference.
**/
private typedef BuiltInConstants = {
	final fatal: LogTypeBuilder;
	final error: LogTypeBuilder;
	final warn: LogTypeBuilder;
	final info: LogTypeBuilder;
	final debug: LogTypeBuilder;
}
