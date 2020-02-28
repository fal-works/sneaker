package sneaker.log;

import haxe.PosInfos;
import sneaker.tag.TagFilterTools;

class LogTypeSetterExtension {
	/**
	 * Overwrites `thisType.tagFilter` with a new filter that checks the tag with `bitMask`.
	 */
	public static function setTagNameFilter(
		thisType: LogType,
		tagName: String
	): LogType {
		thisType.tagFilter = TagFilterTools.createNameFilter(tagName);
		return thisType;
	}

	/**
	 * Overwrites `thisType.tagFilter` with a new filter that checks the tag with `bitMask`.
	 */
	public static function setTagBitsFilter(thisType: LogType, bitMask: Int): LogType {
		thisType.tagFilter = TagFilterTools.createBitsFilter(bitMask);
		return thisType;
	}

	/**
	 * Overwrites `thisType.positionFilter` with a new filter that only accepts `className`.
	 */
	public static function setClassFilter(
		thisType: LogType,
		className: String,
		passNullPosition = false
	): LogType {
		thisType.positionFilter = PosInfosFilterTools.createClassFilter(
			className,
			passNullPosition
		);
		return thisType;
	}

	/**
	 * Overwrites `thisType.positionFilter` with a new filter that only accepts `methodName`.
	 */
	public static function setMethodFilter(
		thisType: LogType,
		methodName: String,
		passNullPosition = false
	): LogType {
		thisType.positionFilter = PosInfosFilterTools.createMethodFilter(
			methodName,
			passNullPosition
		);
		return thisType;
	}

	/**
	 * Overwrites `thisType.positionFilter` with a new filter that only accepts `className` && `methodName`.
	 */
	public static function setClassMethodFilter(
		thisType: LogType,
		className: String,
		methodName: String,
		passNullPosition = false
	): LogType {
		thisType.positionFilter = PosInfosFilterTools.createClassMethodFilter(
			className,
			methodName,
			passNullPosition
		);
		return thisType;
	}

	/**
	 * Overwrites `thisType.positionFormat` with `format`.
	 *
	 * @param format You may either select from `sneaker.format.PosInfosCallbacks` or create your own.
	 */
	public static function setPositionFormat(
		thisType: LogType,
		format: (?pos: Null<PosInfos>) -> String
	): LogType {
		thisType.positionFormat = format;
		return thisType;
	}

	/**
	 * Overwrites `thisType.positionFormat` with `format`.
	 *
	 * @param format You may either select from `sneaker.log.LogFormats` or create your own.
	 */
	public static function setLogFormat(thisType: LogType, format: LogFormat): LogType {
		thisType.logFormat = format;
		return thisType;
	}
}
