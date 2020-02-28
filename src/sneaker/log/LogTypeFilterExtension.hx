package sneaker.log;

class LogTypeFilterExtension {
	/**
	 * Overwrite `thisType.tagFilter` with a new filter that checks the tag with `bitMask`.
	 */
	public static function setTagNameFilter(thisType: LogType, tagName: String): Void {
		thisType.tagFilter = (?tag) -> tag != null && tag.name == tagName;
	}

	/**
	 * Overwrite `thisType.tagFilter` with a new filter that checks the tag with `bitMask`.
	 */
	public static function setTagBitsFilter(thisType: LogType, bitMask: Int): Void {
		thisType.tagFilter = (?tag) -> tag.checkNullable(bitMask);
	}

	/**
	 * Overwrite `thisType.positionFilter` with a new filter that only accepts `className`.
	 */
	public static function setClassFilter(thisType: LogType, className: String): Void {
		thisType.positionFilter = (?pos) -> pos != null && pos.className == className;
	}

	/**
	 * Overwrite `thisType.positionFilter` with a new filter that only accepts `methodName`.
	 */
	public static function setMethodFilter(thisType: LogType, methodName: String): Void {
		thisType.positionFilter = (?pos) -> pos != null && pos.methodName == methodName;
	}

	/**
	 * Overwrite `thisType.positionFilter` with a new filter that only accepts `className` && `methodName`.
	 */
	public static function setClassMethodFilter(
		thisType: LogType,
		className: String,
		methodName: String
	): Void {
		thisType.positionFilter = (?pos) -> pos != null && pos.className == className && pos.methodName == methodName;
	}
}
