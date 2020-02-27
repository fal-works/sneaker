package sneaker.log;

import haxe.PosInfos;
import sneaker.tag.Tag;
import sneaker.print.Printer;

class LogTypeExtension {
	/**
	 * Creates log as a `String` value using `thisType.format`, `thisType.prefix`
	 * and the given values (`message`, `tag` and `pos`).
	 */
	public static inline function createLogString(
		thisType: LogType,
		message: String,
		?tag: Tag,
		?pos: PosInfos
	): String {
		return thisType.logFormat(thisType, message, tag, pos);
	}

	/**
	 * Prints log ignoring all filters, whether or not `thisType.print()` is disabled.
	 */
	public static inline function forcePrint(
		thisType: LogType,
		message: String,
		?tag: Tag,
		?pos: PosInfos
	): Void {
		Printer.println(createLogString(thisType, message, tag, pos));
	}

	/**
	 * Prints log if `tag` matches `thisType.tagFilter` and `pos` matches `thisType.positionFilter`.
	 */
	public static inline function printIfMatch(
		thisType: LogType,
		message: String,
		?tag: Tag,
		?pos: PosInfos
	): Void {
		if (!thisType.tagFilter(tag)) return;
		if (!thisType.positionFilter(pos)) return;

		forcePrint(thisType, message, tag, pos);
	}
}
