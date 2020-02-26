package sneaker.tag;

import haxe.ds.Option;

class TagExtencion {
	/**
	 * `String` value for indicating the absense of a tag.
	 * Used in `formatNullable()` and `formatOptional()`.
	 */
	public static final noTagString = "-";

	/**
	 * Checks if this tag mathces the given condition.
	 * @return `true` if any bit of `(tag).bits` matches `bitMask` (logical AND).
	 */
	public static inline function check(thisTag: Tag, bitMask: Int): Bool {
		return thisTag.bits & bitMask != 0;
	}

	/**
	 * Checks if this tag is not null and also mathces the given condition.
	 * @return `true` if not null and any bit of `thisTag.bits` matches `bitMask` (logical AND).
	 */
	public static inline function checkNullable(thisTag: Null<Tag>, bitMask: Int): Bool {
		return thisTag != null && check(thisTag, bitMask);
	}

	/**
	 * @return `String` form of this tag, or a hyphen (`-`) if null.
	 */
	public static inline function formatNullable(thisTag: Null<Tag>) {
		return thisTag != null ? thisTag.toString() : noTagString;
	}

	/**
	 * @return `String` form of this tag, or a hyphen (`-`) if `None`.
	 */
	public static inline function formatOptional(thisTag: Option<Tag>) {
		return switch (thisTag) {
			case Some(value): value.toString();
			case None: noTagString;
		}
	}
}
