package sneaker.log;

using sneaker.format.PosInfosExtension;

import sneaker.log.LogTypeExtension.*;
import haxe.PosInfos;
import sneaker.tag.Tag;

/**
 * Values that will be assigned when creating a new `LogType` instance.
 * Can also be replaced with custom functions.
 */
@:nullSafety(Strict)
class LogTypeDefaults {
	public static var tagFilter = (?tag:Tag) -> true;
	public static var positionFilter = (?pos:PosInfos) -> true;

	public static var format = (prefix:String, message:String, ?tag:Tag, ?pos
		:PosInfos) -> '${prefix} ${pos.formatClassMethodLine()} | ${tag.formatNullable()} | ${message}';
}

/**
 * Type of log data, e.g. WARNING, INFO etc.
 */
@:using(sneaker.log.LogTypeExtension, sneaker.log.LogTypeFilterExtension)
@:nullSafety(Strict)
class LogType {
	static final doNotPrint = (message:String, ?tag:Tag, ?pos:PosInfos) -> {};

	/** Prefix for appending to the output text. */
	public var prefix:String;

	/**
	 * Predicate for filtering tags.
	 *
	 * Can be replaced either directly or using `setTagNameFilter()` etc.
	 */
	public var tagFilter = LogTypeDefaults.tagFilter;

	/**
	 * Predicate for filtering position information.
	 *
	 * Can be replaced either directly or using `setMethodFilter()` etc.
	 */
	public var positionFilter = LogTypeDefaults.positionFilter;

	/**
	 * Function that formats given values and generates an output `String` value.
	 *
	 * Can be replaced with a custom function.
	 */
	public var format = LogTypeDefaults.format;

	public function new(prefix:String) {
		this.prefix = prefix;

		this.format = LogTypeDefaults.format; // Don't know why but this seems to be necessary
	}

	/**
	 * Prints log. At default it calls `this.printIfMatch()` internally.
	 *
	 * `print()` can be disabled by `this.disablePrint()`, or even replaced with a custom function.
	 */
	public dynamic function print(message:String, ?tag:Tag, ?pos:PosInfos):Void {
		printIfMatch(this, message, tag, pos);
	}

	/**
	 * Disables `this.print()` so that it has no effect.
	 *
	 * For enabling again, you have to rebind any function and assign it to `this.print`.
	 */
	public inline function disablePrint():Void {
		this.print = doNotPrint;
	}
}
