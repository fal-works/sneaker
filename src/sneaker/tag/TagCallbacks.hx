package sneaker.tag;

class TagCallbacks {
	/** @see TagExtension.notNull **/
	public static final notNull = (tag: Null<Tag>) -> TagExtension.notNull(tag);

	/** @see TagExtension.checkName **/
	public static final checkName = (
		tag: Tag,
		name: String
	) -> TagExtension.checkName(tag, name);

	/** @see TagExtension.checkBits **/
	public static final checkBits = (
		tag: Tag,
		bitMask: Int
	) -> TagExtension.checkBits(tag, bitMask);
}
