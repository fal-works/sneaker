package sneaker.macro.extensions;

import haxe.macro.Expr;
#if macro
class ExprExtension {
	/**
		@return `true` if the type of this expression unifies `complexType`.
	**/
	public static function unify(_this: Expr, complexType: ComplexType): Bool {
		final check: Expr = {
			expr: ECheckType(_this, complexType),
			pos: _this.pos
		};
		try {
			Context.typeof(check);
			return true;
		} catch (e: Dynamic) {
			return false;
		}
	}
}
#end
