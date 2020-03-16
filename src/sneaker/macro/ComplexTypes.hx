package sneaker.macro;

#if macro
import haxe.macro.Expr;

/**
	Collection of common `ComplexType` instances.
**/
class ComplexTypes {
	/**
		Same as `(macro:Void)`.
	**/
	public static final voidType: ComplexType = (macro:Void);

	/**
		Same as `(macro:Int)`.
	**/
	public static final intType: ComplexType = (macro:Int);

	/**
		Same as `(macro:Bool)`.
	**/
	public static final boolType: ComplexType = (macro:Bool);
}
#end
