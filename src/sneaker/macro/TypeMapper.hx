package sneaker.macro;

#if macro
using sneaker.macro.TypeMapper;

import haxe.macro.Expr;

class ComplexTypeMapper {
	/**
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return `ComplexType` mapped by `convert`.
	**/
	public static function mapTypes(
		_this: ComplexType,
		convert: ComplexType->ComplexType
	): ComplexType {
		final mappedRecursive = switch _this {
			case TPath(typePath):
				TPath(typePath.mapTypes(convert));
			case TFunction(argumentTypes, returnType):
				TFunction(
					argumentTypes.mapTypes(convert),
					returnType.convertMapTypes(convert)
				);
			case TAnonymous(fields):
				_this;
			case TParent(complexType):
				TParent(complexType.convertMapTypes(convert));
			case TExtend(typePaths, fields):
				TExtend(typePaths.mapTypes(convert), fields);
			case TOptional(complexType):
				TOptional(complexType.convertMapTypes(convert));
			case TNamed(n, complexType):
				TNamed(n, complexType.convertMapTypes(convert));
			case TIntersection(complexTypes):
				TIntersection(complexTypes.mapTypes(convert));
		};

		return convert(mappedRecursive);
	}

	/**
		First applies `convert` and then calls `mapTypes()`.
	**/
	@:allow(sneaker.macro.ComplexTypesMapper)
	static function convertMapTypes(
		_this: ComplexType,
		convert: ComplexType->ComplexType
	): ComplexType {
		return convert(_this).mapTypes(convert);
	}
}

class ComplexTypesMapper {
	/**
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return Array of `ComplexType` mapped by `convert`.
	**/
	public static function mapTypes(
		_this: Array<ComplexType>,
		convert: ComplexType->ComplexType
	): Array<ComplexType> {
		final length = _this.length;
		final newArray: Array<ComplexType> = [];
		newArray.resize(length);

		for (i in 0...length)
			newArray[i] = _this[i].convertMapTypes(convert);

		return newArray;
	}
}

class TypePathMapper {
	/**
		Recursively maps `ComplexType` of type parameters.

		*Note: Types of anonymous structure fields are not converted.*
		@return New `TypePath` of which the type parameters are mapped by `convert`.
	**/
	public static function mapTypes(
		_this: TypePath,
		convert: ComplexType->ComplexType
	): TypePath {
		final params = _this.params;
		return {
			name: _this.name,
			pack: _this.pack,
			sub: _this.sub,
			params: if (params != null) params.mapTypes(convert) else null
		};
	}
}

class TypePathsMapper {
	/**
		Recursively maps `ComplexType` of type parameters.

		*Note: Types of anonymous structure fields are not converted.*
		@return New `TypePath` array of which the type parameters are mapped by `convert`.
	**/
	public static function mapTypes(
		_this: Array<TypePath>,
		convert: ComplexType->ComplexType
	): Array<TypePath> {
		final length = _this.length;
		final newArray: Array<TypePath> = [];
		newArray.resize(length);

		for (i in 0...length)
			newArray[i] = _this[i].mapTypes(convert);

		return newArray;
	}
}

class TypeParamMapper {
	/**
		Recursively maps `ComplexType` (only if `TPType`).

		*Note: Types of anonymous structure fields are not converted.*
		@return `TypeParam` with `ComplexType` mapped by `convert`.
	**/
	public static function mapTypes(
		_this: TypeParam,
		convert: ComplexType->ComplexType
	): TypeParam {
		return switch typeParam {
			case TPType(complexType): TPType(complexType.mapTypes(convert));
			default: typeParam;
		};
	}
}

class TypeParamsMapper {
	/**
		Recursively maps `ComplexType` (only if `TPType`).

		*Note: Types of anonymous structure fields are not converted.*
		@return Array of `TypeParam` with `ComplexType` mapped by `convert`.
	**/
	public static function mapTypes(
		_this: Array<TypeParam>,
		convert: ComplexType->ComplexType
	): Array<TypeParam> {
		final length = _this.length;
		final newTypeParams: Array<TypeParam> = [];
		newTypeParams.resize(length);

		for (i in 0...length)
			newTypeparams[i] = _this[i].mapTypes(convert);

		return newTypeParams;
	}
}
#end
