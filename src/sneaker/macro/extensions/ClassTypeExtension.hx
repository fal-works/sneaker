package sneaker.macro.extensions;

#if macro
import haxe.macro.Type.ClassType;

class ClassTypeExtension {
	/**
		Recursively checks if any of super-classes of `this` has metadata with `metadataName`.
		@return `true` if any super-class has the metadata.
	**/
	public static function anySuperClassHasMetadata(
		_this: ClassType,
		metadataName: String
	): Bool {
		final superClass = _this.superClass;
		if (superClass == null) return false;

		final superClassType = superClass.t.get();
		if (superClassType.meta.has(metadataName)) return true;

		return anySuperClassHasMetadata(superClassType, metadataName);
	}
}
#end
