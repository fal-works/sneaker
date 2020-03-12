package sneaker.log;

using sneaker.log.LogTypeExtension;

import haxe.PosInfos;
import sneaker.tag.Tag;
import sneaker.CompilerFlags;

/**
	Type of log data, e.g. WARNING, INFO etc.

	Each variable/function can be replaced by any custom value or
	using methods that come from the `LogTypeSetterExtension` class.
**/
@:using(sneaker.log.LogTypeExtension, sneaker.log.LogTypeSetterExtension)
class LogType {
	/** Prefix for appending to the output text. **/
	public var prefix: String;

	/** Predicate for filtering tags. **/
	public var tagFilter: (tag: Tag) -> Bool;

	/** Predicate for filtering position information. **/
	public var positionFilter: (?pos: PosInfos) -> Bool;

	/** Function that formats `pos` to a `String` representation. **/
	public var positionFormat: (?pos: PosInfos) -> String;

	/** Function used for creating the entire log text. **/
	public var logFormat: LogFormat;

	/**
		@param logLevel Set value greater than the compiler flag `sneaker_log_level` for disabling `this`.
		@see `sneaker.log.Logger` about the log levels.
	**/
	public function new(prefix: String, logLevel: Int = 0) {
		this.prefix = prefix;

		this.tagFilter = LogTypeDefaults.tagFilter;
		this.positionFilter = LogTypeDefaults.positionFilter;
		this.positionFormat = LogTypeDefaults.positionFormat;
		this.logFormat = LogTypeDefaults.logFormat;

		if (logLevel > CompilerFlags.logLevel.get())
			this.disablePrint();
	}

	/**
		Prints log. At default it calls `this.printIfMatch()` internally.

		`print()` can be disabled by `disablePrint()`, or even replaced with a custom function.
	**/
	public dynamic function print(
		message: String,
		?tag: Tag,
		?pos: PosInfos
	): Void {
		#if !sneaker_print_disable
		this.printIfMatch(message, tag, pos);
		#end
	}
}
