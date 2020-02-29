package sneaker.tag;

/**
	`Tag` instances that are commonly shared & used.
	They can be replaced for your own purpose (e.g. change display names or filtering conditions).
**/
class Tags {
	/** Null object that indicates the absense of a tag. **/
	public static var none: Tag = {
		name: "-",
		bits: 0x00000000
	};

	/** The default `Tag` that will be attached when a `Tagged` instance is created. **/
	public static var anonymous: Tag = {
		name: "no name",
		bits: 0xFFFFFFFF
	}
}
