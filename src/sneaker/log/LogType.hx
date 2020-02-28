package sneaker.log;

import sneaker.log.LogTypeExtension.*;
import haxe.PosInfos;
import sneaker.tag.Tag;

// @formatter:off

/**
 * Type of log data, e.g. WARNING, INFO etc.
 *
 * Each variable/function can be replaced by any custom value or
 * using methods that come from the `LogTypeFilterExtension` class.
 */
@:using(sneaker.log.LogTypeExtension, sneaker.log.LogTypeFilterExtension)
class LogType {
	/** Prefix for appending to the output text. */
	public var prefix: String;

	/**
	 * Predicate for filtering tags.
	 *
	 * Can be replaced either directly or using `setTagNameFilter()` etc.
	 */
	public var tagFilter: (tag: Tag) -> Bool;

	/**
	 * Predicate for filtering position information.
	 *
	 * Can be replaced either directly or using `setMethodFilter()` etc.
	 */
	public var positionFilter: (?pos: PosInfos) -> Bool;

	/**
	 * Function that formats `pos` and generates an output `String` value.
	 *
	 * Can be replaced with any custom function.
	 */
	public var positionFormat: (?pos: PosInfos) -> String;

	/**
	 * Function used for creating log text.
	 *
	 * Can be replaced with any custom function.
	 */
	public var logFormat: LogFormat;

	public function new(prefix: String) {
		this.prefix = prefix;

		this.tagFilter = LogTypeDefaults.tagFilter;
		this.positionFilter = LogTypeDefaults.positionFilter;
		this.positionFormat = LogTypeDefaults.positionFormat;
		this.logFormat = LogTypeDefaults.logFormat;
	}

	/**
	 * Prints log. At default it calls `this.printIfMatch()` internally.
	 *
	 * `print()` can be disabled by `this.disablePrint()`, or even replaced with a custom function.
	 */
	public dynamic function print(
		message: String,
		?tag: Tag,
		?pos: PosInfos
	): Void {
		#if !sneaker_print_disable
		printIfMatch(this, message, tag, pos);
		#end
	}
}
