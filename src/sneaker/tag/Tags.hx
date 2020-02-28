package sneaker.tag;

/**
 * `Tag` instances that are commonly shared & used.
 */
class Tags {
	public static var nullTag: Tag = {
		name: "-",
		bits: 0x00000000
	};

	/** Default `Tag` instance that will be attached when a `Tagged` instance is created. */
	public static var defaultTag: Tag = {
		name: "no name",
		bits: 0xFFFFFFFF
	}
}
