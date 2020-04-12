package sneaker.macro.extensions;

import haxe.macro.Expr;
#if macro
class ExprExtension {
	/**
		@return `true` if the type of this expression unifies `complexType`.
	**/
	public static function unify(_this: Expr, complexType: ComplexType): Bool {
		try {
			Context.typeof(as(_this, complexType));
			return true;
		} catch (e: Dynamic) {
			return false;
		}
	}

	/**
		@return `(expr: T)` expression.
	**/
	public static function as(_this: Expr, complexType: ComplexType): Expr {
		return {
			expr: ECheckType(_this, complexType),
			pos: _this.pos
		};
	}
}
#end
