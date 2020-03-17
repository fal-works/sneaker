package sneaker.macro;

#if macro
using haxe.macro.TypeTools;

import haxe.macro.Expr;
import haxe.macro.Type;
import sneaker.types.Result;
import sneaker.macro.Types.EnumAbstractType;

/**
	Functions for converting macro-related types.
**/
class MacroCaster {
	/**
		@param param `Type.TypeParameter`
		@return `Expr.ComplexType`
	**/
	public static function typeParameterToComplexType(param: TypeParameter): ComplexType
		return Context.toComplexType(param.t);

	/**
		@param param `Type.TypeParameter`
		@return Enum `Expr.TypeParam` (instance `TPType`)
	**/
	public static function typeParameterToTypeParam(param: TypeParameter): TypeParam
		return TPType(typeParameterToComplexType(param));

	/**
		@param `Type.Ref<ClassType>`
		@return `Expr.TypePath`
	**/
	public static function typeRefToTypePath(typeRef: Ref<ClassType>): TypePath {
		final type = typeRef.get();
		return {
			pack: type.pack,
			name: type.name,
			params: type.params.map(typeParameterToTypeParam)
		}
	}
}

class TypeCaster {
	/**
		@param type `Type`
		@return `AbstractType` value, or an error message if not an abstract.
	**/
	public static function toAbstractType(type: Type): Result<AbstractType, String> {
		return switch (type.follow()) {
			case TAbstract(_.get() => abstractType, _):
				Ok(abstractType);
			default:
				notAbstract;
		}
	}

	/**
		Value returned if `typeToAbstractType()` fails.
	**/
	static final notAbstract: Result<AbstractType, String> = Failed('Not an abstract');
}

class AbstractTypeCaster {
	/**
		@param type `AbstractType`
		@return `EnumAbstractType` value, or an error message if failed.
	**/
	public static function toEnumAbstractType(
		type: AbstractType
	): Result<EnumAbstractType, String> {
		return EnumAbstractType.fromAbstractType(type);
	}
}
#end
