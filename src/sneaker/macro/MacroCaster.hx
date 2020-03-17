package sneaker.macro;

#if macro
import haxe.macro.Expr;
import haxe.macro.Type;

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
#end
