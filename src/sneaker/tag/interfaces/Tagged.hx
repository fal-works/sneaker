package sneaker.tag.interfaces;

/**
	Any object that is tagged, i.e. that has getter/setter for `tag`.
**/
@:using(sneaker.tag.TaggedExtension)
interface Tagged {
	/** Tag for logging. **/
	public var tag(get, set): Tag;
}
