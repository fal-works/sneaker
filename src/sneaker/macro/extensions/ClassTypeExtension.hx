package sneaker.macro.extensions;

#if macro
import haxe.macro.Type;

class ClassTypeExtension {
	/**
		@return `true` if `this` or any of its superclasses implements the given interface.
	**/
	public static function implementsInterface(
		_this: ClassType,
		interfaceModulePath: String,
		?interfaceName: String
	): Bool {
		final predicate: (
			ref: { t: Ref<ClassType>, params: Array<Type> }
		) -> Bool = if (interfaceName == null)
			function(ref) return ref.t.get().module == interfaceModulePath;
		else
			function(ref) {
				final type = ref.t.get();
				return type.module == interfaceModulePath && type.name == interfaceName;
			}

		var classType: Null<ClassType> = _this;
		while (classType != null) {
			final interfaces = classType.interfaces;
			for (i in 0...interfaces.length) if (predicate(interfaces[i])) return true;

			final superClassRef = classType.superClass;
			classType = if (superClassRef != null) superClassRef.t.get(); else null;
		}

		return false;
	}

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
