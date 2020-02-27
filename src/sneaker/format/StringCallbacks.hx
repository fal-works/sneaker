package sneaker.format;

import haxe.ds.Option;

class StringCallbacks {
	static final dot = ".";
	static final slash = "/";

	/**
	 * Converts `Null<T>` to `Option<String>`.
	 * @return `None` if null, `Some(s)` if not null.
	 */
	public static final toOptionalString = StringExtension.toOptionalString;

	/**
	 * @return Sub-string after the last occurrence of dot (`.`).
	 */
	public static final sliceAfterLastDot = StringExtension.sliceAfterLastDot;

	/**
	 * @return Sub-string after the last occurrence of slash (`/`).
	 */
	public static final sliceAfterLastSlash = StringExtension.sliceAfterLastSlash;
}
