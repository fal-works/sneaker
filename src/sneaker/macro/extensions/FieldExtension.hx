package sneaker.macro.extensions;

#if macro
import haxe.macro.Expr;

class FieldExtension {
	/**
		@return `true` if `this` field has a metadata with `name`.
	**/
	public static function hasMetadata(_this: Field, name: String): Bool {
		final metadataArray = _this.meta;
		if (metadataArray == null) return false;

		for (i in 0...metadataArray.length)
			if (metadataArray[i].name == name) return true;

		return false;
	}

	/**
		@return `true` if `this.name == "new"`.
	**/
	public static function isNew(_this: Field): Bool
		return _this.name == "new";

	/**
		@return Shallow copy of `this`.
	**/
	public static function clone(_this: Field): Field {
		final cloned: Field = {
			name: _this.name,
			doc: _this.doc,
			access: _this.access.copy(),
			kind: _this.kind,
			pos: Reflect.copy(_this.pos),
			meta: if (_this.meta != null) _this.meta.map(Reflect.copy) else null
		};
		return cloned;
	}

	/**
		Overwrites `this.name`.
		@return `this` field.
	**/
	public static function setName(_this: Field, name: String): Field {
		_this.name = name;
		return _this;
	}

	/**
		Overwrites `this.doc`.
		@return `this` field.
	**/
	public static function setDoc(_this: Field, doc: Null<String>): Field {
		_this.doc = doc;
		return _this;
	}

	/**
		Overwrites `this.kind`.
		@return `this` field.
	**/
	public static function setFieldType(_this: Field, fieldType: FieldType): Field {
		_this.kind = fieldType;
		return _this;
	}

	/**
		Overwrites the `kind` of `this` field with a variable type of `type`.
		@return `this` field.
	**/
	public static function setVariableType(_this: Field, type: ComplexType): Field {
		_this.kind = FVar(type);
		return _this;
	}

	/**
		Adds `access` to `this` field.
		@param preserve if `true`, concatenates old values instead of replacing them.
		@return `this` field.
	**/
	public static function setAccess(
		_this: Field,
		access: Array<Access>,
		preserve = true
	): Field {
		_this.access = if (preserve) _this.access.concat(access) else access;
		return _this;
	}

	/**
		Overwrites `this.pos`.
		@return `this` field.
	**/
	public static function setPosition(_this: Field, pos: Position): Field {
		_this.pos = pos;
		return _this;
	}

	/**
		@return `true` if both fields have the same name.
	**/
	public static function hasSameName(_this: Field, other: Field): Bool
		return _this.name == other.name;
}
#end
