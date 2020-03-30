package sneaker.macro;

#if macro
using haxe.macro.TypeTools;
using haxe.macro.ExprTools;

import haxe.macro.Expr;
import haxe.macro.Type;
import sneaker.types.Result;
import sneaker.macro.EnumAbstractType;
import sneaker.types.Maybe;

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
				Failed('Not an abstract: ${type}');
		}
	}

	/**
		@param type `Type`
		@return `Ref<ClassType>` in `Maybe` representation.
	**/
	public static function toClassTypeRef(type: Type): Maybe<Ref<ClassType>> {
		return switch (type.follow()) {
			case TInst(typeRef, params):
				typeRef;
			default:
				Maybe.from(null);
		}
	}

	/**
		@param type `Type`
		@return `ClassType` in `Maybe` representation.
	**/
	public static function toClassType(type: Type): Maybe<ClassType> {
		return switch (type.follow()) {
			case TInst(typeRef, params):
				typeRef.get();
			default:
				Maybe.from(null);
		}
	}
}

class TypeParameterCaster {
	/**
		@param param `Type.TypeParameter`
		@return `Expr.ComplexType`
	**/
	public static function toComplexType(param: TypeParameter): ComplexType
		return Context.toComplexType(param.t);

	/**
		@param param `Type.TypeParameter`
		@return Enum `Expr.TypeParam` (instance `TPType`)
	**/
	public static function toTypeParam(param: TypeParameter): TypeParam
		return TPType(toComplexType(param));
}

class ClassTypeCaster {
	/**
		@param `ClassType`
		@return `Expr.TypePath`
	**/
	public static function toTypePath(classType: ClassType): TypePath {
		return {
			pack: classType.pack,
			name: classType.name,
			params: classType.params.map(TypeParameterCaster.toTypeParam)
		}
	}

	/**
		@param `Type.Ref<ClassType>`
		@return `Expr.TypePath`
	**/
	public static function refToTypePath(classTypeRef: Ref<ClassType>): TypePath
		return toTypePath(classTypeRef.get());
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

class ExprCaster {
	/**
		@param expression `Expr`
		@return `Type`, or error message if failed.
	**/
	public static function typeof(expression: Expr): MacroResult<Type> {
		try {
			final type = Context.typeof(expression);
			return Ok(type);
		} catch(_: Dynamic) {
			return Failed('Type not found: ${expression.toString()}', expression.pos);
		}
	}
}
#end
