package sneaker.macro.extensions;

#if macro
import haxe.macro.Expr;
import haxe.macro.Type;
import haxe.macro.ExprTools;
import sneaker.types.Maybe;

class ExprExtension {
	/**
		@return `(expr: T)` expression.
	**/
	public static function as(_this: Expr, complexType: ComplexType): Expr {
		return {
			expr: ECheckType(_this, complexType),
			pos: _this.pos
		};
	}

	/**
		Types `(thisExpr : complexType)`.
		@return `Type` representation, or an error message if failed.
	**/
	public static function checkType(_this: Expr, complexType: ComplexType): MacroResult<Type> {
		try {
			return Ok(Context.typeof(as(_this, complexType)));
		} catch (e: Dynamic) {
			return Failed("The expression does not unify the specified type", _this.pos);
		}
	}

	/**
		@return `true` if `(thisExpr : complexType)` succeeds.
	**/
	public static function passesTypeCheck(_this: Expr, complexType: ComplexType): Bool {
		return checkType(_this, complexType).isOk();
	}

	/**
		@return `true` if the type of this expression unifies `complexType`.
	**/
	public static function unify(_this: Expr, type: Type): Bool {
		try {
			return Context.unify(Context.typeof(_this), type);
		} catch (e: Dynamic) {
			return false;
		}
	}

	/**
		@return `this` expression with `:privateAccess` metadata attached.
	**/
	public static function privateAccess(_this: Expr): Expr {
		final expression = macro @:privateAccess $_this;
		expression.pos = _this.pos;
		return expression;
	}

	/**
		@return Value that `this` represents.
		`Maybe.none()` if `this` is not supported by `haxe.macro.ExprTools.getValue`.
	**/
	public static function getValue(_this: Expr): Maybe<Dynamic> {
		try {
			return Maybe.from(ExprTools.getValue(_this));
		} catch (_: Dynamic) {
			return Maybe.none();
		}
	}

	/**
		@return `Int` literal value that `this` represents.
	**/
	public static function getIntLiteralValue(_this: Expr): Maybe<Int> {
		return switch (_this.expr) {
			case EConst(CInt(v)): Maybe.from(Std.parseInt(v));
			default: Maybe.none();
		}
	}

	/**
		@return `Float` literal value that `this` represents.
	**/
	public static function getFloatLiteralValue(_this: Expr): Maybe<Float> {
		return switch (_this.expr) {
			case EConst(CFloat(v)): Maybe.from(Std.parseFloat(v));
			default: Maybe.none();
		}
	}

	/**
		@return `String` literal value that `this` represents.
	**/
	public static function getStringLiteralValue(_this: Expr): Maybe<String> {
		return switch (_this.expr) {
			case EConst(CString(s)): s;
			default: Maybe.none();
		}
	}

	/**
		@return `Bool` identifier value that `this` represents.
	**/
	public static function getBoolIdentifierValue(_this: Expr): Maybe<Bool> {
		return switch (_this.expr) {
			case EConst(CIdent("true")): Maybe.from(true);
			case EConst(CIdent("false")): Maybe.from(false);
			default: Maybe.none();
		}
	}

	/**
		@return `true` if `this` is a `null` identifier.
	**/
	public static function isNullIdentifier(_this: Expr): Bool {
		return switch (_this.expr) {
			case EConst(CIdent("null")): true;
			default: false;
		}
	}
}
#end
