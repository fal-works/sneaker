package sneaker.macro;

#if macro
using haxe.macro.ComplexTypeTools;
using haxe.macro.TypeTools;

import haxe.macro.Expr;

/**
	Functions for comparing instances of macro-related types.
**/
class MacroComparator {
	/**
		Roughly checks unification of two `Expr.ComplexType` instances.
		Might not work in some cases as this first converts each type to `haxe.macro.Type`.
		@return `true` if `a` and `b` unify.
	**/
	public static function unifyComplex(a: ComplexType, b: ComplexType): Bool {
		return if (a == null)
			throw "a is null."
		else if (b == null)
			throw "b is null."
		else
			a.toType().unify(b.toType());
	}

	/**
		Roughly compares two `Expr.TypeParm` instances.
		@return `true` if maybe equal.
	**/
	public static function compareTypeParam(a: TypeParam, b: TypeParam): Bool {
		return switch a {
			case TPType(aType):
				switch b {
					case TPType(bType): unifyComplex(aType, bType);
					case TPExpr(bExpr): false;
				}
			case TPExpr(aExpr):
				switch b {
					case TPType(aType): false;
					case TPExpr(bExpr): Type.enumEq(aExpr.expr, bExpr.expr);
				}
		}
	}
}
#end
