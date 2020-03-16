package sneaker.log;

import haxe.PosInfos;
import sneaker.tag.Tag;
import sneaker.print.Printer;

class LogTypeExtension {
	// @formatter:off
	static final doNotPrint = (message: String, ?tag: Tag, ?pos: PosInfos) -> {};
	// @formatter:on
	//

	/**
		Creates log as a `String` value using `this.format`, `this.prefix`
		and the given values (`message`, `tag` and `pos`).
	**/
	public static inline function createLogString(
		_this: LogType,
		message: String,
		?tag: Tag,
		?pos: PosInfos
	): String {
		return _this.logFormat(_this, message, tag.notNull(), pos);
	}

	/**
		Prints log ignoring all filters, whether or not `this.print()` is disabled.
	**/
	public static inline function forcePrint(
		_this: LogType,
		message: String,
		?tag: Tag,
		?pos: PosInfos
	): Void {
		Printer.println(createLogString(_this, message, tag, pos));
	}

	/**
		Prints log if `tag` matches `this.tagFilter` and `pos` matches `this.positionFilter`.
	**/
	public static inline function printIfMatch(
		_this: LogType,
		message: String,
		?tag: Tag,
		?pos: PosInfos
	): Void {
		final notNullTag = tag.notNull();

		if (_this.tagFilter(notNullTag) && _this.positionFilter(pos)) {
			Printer.println(_this.logFormat(_this, message, notNullTag, pos));
		}
	}

	/**
		Disables `this.print()` so that it has no effect.

		For enabling again, you have to rebind any function and assign it to `this.print`.
	**/
	public static inline function disablePrint(_this: LogType): Void {
		_this.print = doNotPrint;
	}

	/**
		@return `this` with overwritten `tagFilter` and `positionFilter`.
	**/
	public static inline function copyFiltersFrom(
		_this: LogType,
		other: LogType
	): LogType {
		_this.tagFilter = other.tagFilter;
		_this.positionFilter = other.positionFilter;
		return _this;
	}

	/**
		@return `this` with overwritten `positionFormat` and `logFormat`.
	**/
	public static inline function copyFormatsFrom(
		_this: LogType,
		other: LogType
	): LogType {
		_this.positionFormat = other.positionFormat;
		_this.logFormat = other.logFormat;
		return _this;
	}
}
