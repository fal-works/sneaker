package sneaker.tag;

@:using(sneaker.tag.TagExtension)
class Tag {
	/** Name for inserting to log messages. */
	public var name:String;

	/**
	 * Bit array for specifying to which category this tag belongs.
	 * Can be used when filtering tags using a bit mask.
	 */
	public var bits:Int;

	/**
	 * @param name
	 * @param bits Defaults to `0x00000000` (all bits not set).
	 */
	public function new(name:String, bits:Int = 0x00000000) {
		this.name = name;
		this.bits = bits;
	}

	public inline function toString():String {
		return this.name;
	}
}
