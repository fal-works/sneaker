package sneaker.tag;

class TagExtension {
	/**
	 * @return If not null, `thisTag`. If null, `Tags.none`.
	 */
	public static inline function notNull(thisTag: Null<Tag>): Tag {
		return if (thisTag != null) thisTag else Tags.none;
	}

	/**
	 * @return `true` if `thisTag` has the same name as the given `name`.
	 */
	public static inline function checkName(thisTag: Tag, name: String): Bool {
		return thisTag.name == name;
	}

	/**
	 * Checks if this tag mathces the given condition.
	 * @return `true` if any bit of `thisTag.bits` matches `bitMask` (logical AND).
	 */
	public static inline function checkBits(thisTag: Tag, bitMask: Int): Bool {
		return thisTag.bits & bitMask != 0;
	}
}
