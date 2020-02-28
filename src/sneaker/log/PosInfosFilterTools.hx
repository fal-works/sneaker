package sneaker.log;

import haxe.PosInfos;

class PosInfosFilterTools {
	/**
	 * @return Filter function that returns `true` if a given position matches `className`.
	 */
	public static function createClassFilter(
		className: String,
		passIfNull = false
	): (?pos: PosInfos) -> Bool {
		return (?pos) -> if (pos != null) pos.className == className else passIfNull;
	}

	/**
	 * @return Filter function that returns `true` if a given position matches `methodName`.
	 */
	public static function createMethodFilter(
		methodName: String,
		passIfNull = false
	): (?pos: PosInfos) -> Bool {
		return (?pos) -> if (pos != null) pos.methodName == methodName else passIfNull;
	}

	/**
	 * @return Filter function that returns `true` if a given position matches `className` and `methodName`.
	 */
	public static function createClassMethodFilter(
		className: String,
		methodName: String,
		passIfNull = false
	): (?pos: PosInfos) -> Bool {
		return (?pos) -> if (pos != null) pos.className == className && pos.methodName == methodName else passIfNull;
	}
}
