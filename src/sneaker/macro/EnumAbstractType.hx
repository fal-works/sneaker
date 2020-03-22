package sneaker.macro;

#if macro
using haxe.macro.TypeTools;
import haxe.macro.Expr;
import haxe.macro.Type;
import sneaker.types.Result;

/**
	A kind of `Type.AbstractType` instance that hs `@:enum` metadata.
**/
@:forward
@:using(sneaker.macro.EnumAbstractType.EnumAbstractTypeExtension)
abstract EnumAbstractType(AbstractType) to AbstractType {
	/**
		@param abstractType `Type.AbstractType`
		@return `EnumAbstractType` value, or an error message if `:enum` metadata is missing.
	**/
	public static inline function fromAbstractType(
		abstractType: AbstractType
	): Result<EnumAbstractType, String> {
		return if (abstractType.meta.has(":enum"))
			Ok(new EnumAbstractType(abstractType))
		else
			failed;
	}

	/**
		@return The underlying `AbstractType` value.
	**/
	@:to public inline function toAbstractType(): AbstractType return this;

	/**
		@return `ComplexType` value converted from the underlying `haxe.macro.Type`.
	**/
	public inline function toComplexType(): ComplexType return this.type.toComplexType();

	/**
		@return `ComplexType` value converted using `TypeTools.toTypePath`.
	**/
	@:access(haxe.macro.TypeTools)
	public inline function toComplexType2(): ComplexType return TPath(TypeTools.toTypePath(this, []));

	static final failed: Result<EnumAbstractType, String> = Failed('Missing @:enum metadata');

	inline function new(abstractType: AbstractType)
		this = abstractType;
}

class EnumAbstractTypeExtension {
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
