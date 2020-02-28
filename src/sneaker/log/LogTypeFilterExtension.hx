package sneaker.log;

import sneaker.tag.TagFilterTools;

class LogTypeFilterExtension {
	/**
	 * Overwrite `thisType.tagFilter` with a new filter that checks the tag with `bitMask`.
	 */
	public static function setTagNameFilter(thisType: LogType, tagName: String): Void {
		thisType.tagFilter = TagFilterTools.createNameFilter(tagName);
	}

	/**
	 * Overwrite `thisType.tagFilter` with a new filter that checks the tag with `bitMask`.
	 */
	public static function setTagBitsFilter(thisType: LogType, bitMask: Int): Void {
		thisType.tagFilter = TagFilterTools.createBitsFilter(bitMask);
	}

	/**
	 * Overwrite `thisType.positionFilter` with a new filter that only accepts `className`.
	 */
	public static function setClassFilter(
		thisType: LogType,
		className: String,
		passNullPosition = false
	): Void {
		thisType.positionFilter = PosInfosFilterTools.createClassFilter(
			className,
			passNullPosition
		);
	}

	/**
	 * Overwrite `thisType.positionFilter` with a new filter that only accepts `methodName`.
	 */
	public static function setMethodFilter(
		thisType: LogType,
		methodName: String,
		passNullPosition = false
	): Void {
		thisType.positionFilter = PosInfosFilterTools.createMethodFilter(
			methodName,
			passNullPosition
		);
	}

	/**
	 * Overwrite `thisType.positionFilter` with a new filter that only accepts `className` && `methodName`.
	 */
	public static function setClassMethodFilter(
		thisType: LogType,
		className: String,
		methodName: String,
		passNullPosition = false
	): Void {
		thisType.positionFilter = PosInfosFilterTools.createClassMethodFilter(
			className,
			methodName,
			passNullPosition
		);
	}
}
