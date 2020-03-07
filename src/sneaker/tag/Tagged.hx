package sneaker.tag;

/**
	Base class which has a `tag` for logging.
**/
class Tagged implements sneaker.tag.interfaces.Tagged {
	#if sneaker_tagged_disable
	/**
		Tag for logging.
		The getter returns always `Tags.anonymous` and the setter has no effect
		as the compilation flag `sneaker_tagged_disable` is on.
	**/
	public var tag(get, set): Tag;

	inline function get_tag()
		return Tags.anonymous;

	inline function set_tag(_tag)
		return Tags.anonymous;
	#else

	/**
		Tag for logging.

		Note that the default value is a shared instance (`Tags.anonymous`)
		and you should create and assign a new one if you want to use tags for logging feature.
	**/
	@:isVar public var tag(get, set) = Tags.anonymous;

	inline function get_tag()
		return tag;

	inline function set_tag(newTag)
		return tag = newTag;
	#end

	public function new() {}
}
