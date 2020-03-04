package sneaker.tag;

@:structInit
@:using(sneaker.tag.TagExtension)
class Tag {
	/** Name for inserting to log messages. **/
	@:isVar public var name(get, null): String;

	/**
		Bit array for specifying to which category this tag belongs.
		Can be used when filtering tags using a bit mask.
	**/
	@:isVar public var bits(get, null): Int;

	/**
		@param name
		@param bits Defaults to `0xFFFFFFFF` (all bits set).
	**/
	public function new(name: String, bits: Int = 0xFFFFFFFF) {
		this.name = name;
		this.bits = bits;
	}

	public inline function toString(): String {
		return name;
	}

	inline function get_name() {
		return name;
	}

	inline function get_bits() {
		return bits;
	}
}
