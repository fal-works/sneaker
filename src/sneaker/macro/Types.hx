package sneaker.macro;

#if macro
/**
	An array of `Field`s.
	The return type of a build macro function should be `Null<Fields>`.
**/
typedef Fields = Array<haxe.macro.Expr.Field>;

/**
	Alias for `haxe.macro.Type`.
**/
typedef MacroType = haxe.macro.Type;

/**
	Array of `haxe.macro.Type`.
	This is also the return type of `haxe.macro.Context.getModule()`.
**/
typedef MacroModule = Array<haxe.macro.Type>;
#end
