package sneaker.tag;

/**
 * Base class which has a `tag` for logging.
 */
class Tagged implements sneaker.tag.interfaces.Tagged {
	#if sneaker_tagged_disable
	/**
	 * Tag for logging.
	 * The getter returns always `Tagged.defaultTag` and the setter has no effect
	 * as the compilation flag `sneaker_tagged_disable` is on.
	 */
	public var tag(get, set): Tag;

	public inline function get_tag()
		return defaultTag;

	public inline function set_tag(_tag)
		return defaultTag;
	#else

	/**
	 * Tag for logging.
	 *
	 * Note that the default value is a shared instance (`Tags.defaultTag`)
	 * and you should create and assign a new one if you want to use tags for logging feature.
	 */
	@:isVar public var tag(get, set) = Tags.defaultTag;

	public inline function get_tag()
		return tag;

	public inline function set_tag(newTag)
		return tag = newTag;
	#end

	public function new() {}
}
