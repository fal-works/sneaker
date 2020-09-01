package sneaker.tag;

class TagFilterTools {
	/**
		@return Filter function that returns `true` if a tag's name matches `name`.
	**/
	public static function createNameFilter(name: String): Tag->Bool {
		return (tag: Tag) -> tag.checkName(name);
	}

	/**
		@return Filter function that returns `true` if a tag's bits match `bitMask`.
	**/
	public static function createBitsFilter(bitMask: Int): Tag->Bool {
		return (tag: Tag) -> tag.checkBits(bitMask);
	}
}
