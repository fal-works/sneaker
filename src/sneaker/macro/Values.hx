package sneaker.macro;

#if macro
using haxe.macro.ComplexTypeTools;

import haxe.macro.Expr;
import haxe.macro.Type;

/**
	Collection of values for common usage.
**/
class Values {
	/**
		Same as `(macro:Void)`.
	**/
	public static final voidComplexType: ComplexType = (macro:Void);

	/**
		Same as `(macro:Int)`.
	**/
	public static final intComplexType: ComplexType = (macro:Int);

	/**
		Same as `(macro:Bool)`.
	**/
	public static final boolComplexType: ComplexType = (macro:Bool);

	/**
		`Type` value for `Void`.
	**/
	public static final voidType: Type = voidComplexType.toType();

	/**
		`Type` value for `Int`.
	**/
	public static final intType: Type = voidComplexType.toType();

	/**
		`Type` value for `Bool`.
	**/
	public static final boolType: Type = voidComplexType.toType();

	/**
		Null object for `Expr.Field`.
	**/
	public static final nullField: Field = {
		name: "",
		kind: FVar(null, null),
		pos: Context.currentPos()
	};
}
#end
