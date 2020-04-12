package sneaker.macro.extensions;

#if macro
import haxe.macro.Expr;
import haxe.macro.Type;

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
}
#end
