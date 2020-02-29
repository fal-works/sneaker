package sneaker.log;

import haxe.PosInfos;
import sneaker.tag.Tag;
import sneaker.print.Printer;

class LogTypeExtension {
	// @formatter:off
	static final doNotPrint = (
		message: String,
		?tag: Tag,
		?pos: PosInfos
	) -> {};
	// @formatter:on
	//

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
		return thisType.logFormat(thisType, message, tag.notNull(), pos);
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
		final notNullTag = tag.notNull();

		if (thisType.tagFilter(notNullTag) && thisType.positionFilter(pos)) {
			Printer.println(thisType.logFormat(thisType, message, notNullTag, pos));
		}
	}

	/**
	 * Disables `thisType.print()` so that it has no effect.
	 *
	 * For enabling again, you have to rebind any function and assign it to `thisType.print`.
	 */
	public static inline function disablePrint(thisType: LogType): Void {
		thisType.print = doNotPrint;
	}
}
