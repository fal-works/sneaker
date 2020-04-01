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
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return Nullable `ComplexType` mapped by `convert`.
	**/
	public static function mapTypesNullable(
		_this: Null<ComplexType>,
		convert: ComplexType->ComplexType
	): Null<ComplexType> {
		return if (_this != null) _this.mapTypes(convert) else null;
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

	/**
		First applies `convert` and then calls `mapTypes()`, only if not `null`.
	**/
	@:allow(sneaker.macro.FieldTypeMapper)
	static function convertMapTypesNullable(
		_this: Null<ComplexType>,
		convert: ComplexType->ComplexType
	): Null<ComplexType> {
		return if (_this != null) _this.convertMapTypes(convert) else null;
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

	/**
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return Nullable array of `ComplexType` mapped by `convert`.
	**/
	public static function mapTypesNullable(
		_this: Null<Array<ComplexType>>,
		convert: ComplexType->ComplexType
	): Null<Array<ComplexType>> {
		return if (_this != null) _this.mapTypes(convert) else null;
	}
}

class FunctionTypeMapper {
	/**
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return `Function` with types mapped by `convert`.
	**/
	public static function mapTypes(
		_this: Function,
		convert: ComplexType->ComplexType
	): Function
		return {
			ret: _this.ret.mapTypesNullable(convert),
			args: [
				for (a in _this.args) {
					name: a.name,
					value: a.value,
					type: a.type.mapTypesNullable(convert),
					meta: a.meta,
				}
			],
			expr: _this.expr,
			params: _this.params.mapTypesNullable(convert),
		}
}

class FieldTypeMapper {
	/**
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return `Field` with types mapped by `convert`.
	**/
	public static function mapTypes(
		_this: Field,
		convert: ComplexType->ComplexType
	): Field {
		final kind = switch _this.kind {
			case FVar(complexType, expression):
				FVar(complexType.convertMapTypesNullable(convert), expression);
			case FProp(get, set, complexType, expression):
				FProp(
					get,
					set,
					complexType.convertMapTypesNullable(convert),
					expression
				);
			case FFun(f):
				FFun(f.mapTypes(convert));
		};

		return {
			name: _this.name,
			pos: _this.pos,
			kind: kind,
			access: copyNullableArray(_this.access),
			meta: copyNullableArray(_this.meta),
			doc: _this.doc
		};
	}

	static function copyNullableArray<T>(array: Null<Array<T>>): Null<Array<T>>
		return if (array != null) array.copy() else null;
}

class FieldsTypeMapper {
	/**
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return Array of `Field` with types mapped by `convert`.
	**/
	public static function mapTypes(
		_this: Array<Field>,
		convert: ComplexType->ComplexType
	): Array<Field> {
		final length = _this.length;
		final newArray: Array<Field> = [];
		newArray.resize(length);

		for (i in 0...length)
			newArray[i] = _this[i].mapTypes(convert);

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
		return switch _this {
			case TPType(complexType): TPType(complexType.mapTypes(convert));
			default: _this;
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
		final newArray: Array<TypeParam> = [];
		newArray.resize(length);

		for (i in 0...length)
			newArray[i] = _this[i].mapTypes(convert);

		return newArray;
	}
}

class TypeParamDeclMapper {
	/**
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return `TypeParamDecl` with types mapped by `convert`.
	**/
	public static function mapTypes(
		_this: TypeParamDecl,
		convert: ComplexType->ComplexType
	): TypeParamDecl {
		return {
			name: _this.name,
			meta: _this.meta,
			params: _this.params.mapTypes(convert),
			constraints: switch _this.constraints {
				case null: null;
				case complexTypes: complexTypes.mapTypes(convert);
			}
		};
	}
}

class TypeParamDeclsMapper {
	/**
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return Array of `TypeParamDecl` with types mapped by `convert`.
	**/
	public static function mapTypes(
		_this: Array<TypeParamDecl>,
		convert: ComplexType->ComplexType
	): Array<TypeParamDecl> {
		final length = _this.length;
		final newArray: Array<TypeParamDecl> = [];
		newArray.resize(length);

		for (i in 0...length)
			newArray[i] = _this[i].mapTypes(convert);

		return newArray;
	}

	/**
		Recursively maps `ComplexType`.

		*Note: Types of anonymous structure fields are not converted.*
		@return Nullable array of `TypeParamDecl` with types mapped by `convert`.
	**/
	public static function mapTypesNullable(
		_this: Null<Array<TypeParamDecl>>,
		convert: ComplexType->ComplexType
	): Null<Array<TypeParamDecl>> {
		return if (_this != null) _this.mapTypes(convert) else null;
	}
}
#end
