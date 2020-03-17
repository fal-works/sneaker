package sneaker.macro;

#if macro
import haxe.macro.Type;
import sneaker.macro.Types.EnumAbstractType;

class EnumAbstractExtension {
	/**
		@return Enum abstract instance fields of `type` as an array of `Type.ClassField`.
	**/
	public static function getInstances(type: EnumAbstractType): Array<ClassField> {
		final implementation = type.impl;
		if (implementation == null)
			return null;

		final staticFields = implementation.get().statics.get();

		return staticFields.filter(isEnumAbstractInstance);
	}

	/**
		Used internally in `getInstances()`.
	**/
	static function isEnumAbstractInstance(field: ClassField): Bool {
		final meta = field.meta;
		return meta.has(":enum") && meta.has(":impl");
	}
}
#end
