package sneaker.tag;

import haxe.ds.Option;

class TagExtencion {
	public static inline function notNull(thisTag: Null<Tag>): Tag {
		return if (thisTag != null) thisTag else Tags.none;
	}

	/**
	 * Checks if this tag mathces the given condition.
	 * @return `true` if any bit of `(tag).bits` matches `bitMask` (logical AND).
	 */
	public static inline function check(thisTag: Tag, bitMask: Int): Bool {
		return thisTag.bits & bitMask != 0;
	}

	/**
	 * @return `String` form of this tag, or a hyphen (`-`) if `None`.
	 */
	public static inline function formatOptional(thisTag: Option<Tag>) {
		return switch (thisTag) {
			case Some(value): value.toString();
			case None: "-";
		}
	}
}
