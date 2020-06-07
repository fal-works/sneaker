package sneaker.tag;

@:structInit
@:using(sneaker.tag.TagExtension)
class Tag {
	/** Name for inserting to log messages. **/
	public var name(get, never): String;

	/**
		Bit array for specifying to which category this tag belongs.
		Can be used when filtering tags using a bit mask.
	**/
	public var bits(get, never): Int;

	#if !sneaker_tag_disable
	final internalName: String;
	final internalBits: Int;
	#end

	/**
		@param name
		@param bits Defaults to `0xFFFFFFFF` (all bits set).
	**/
	public function new(name: String, bits: Int = 0xFFFFFFFF) {
		#if !sneaker_tag_disable
		this.internalName = name;
		this.internalBits = bits;
		#end
	}

	public inline function toString(): String
		return name;

	extern inline function get_name(): String
		return #if sneaker_tag_disable "-" #else internalName #end;

	extern inline function get_bits(): Int
		return #if sneaker_tag_disable 0x00000000 #else internalBits #end;
}
