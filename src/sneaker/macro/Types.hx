package sneaker.macro;

import haxe.macro.Expr;

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

/**
	Information about a module.
**/
typedef ModuleInfo = {
	path: String,
	name: String,
	packagePath: String,
	packages: Array<String>
}

#if macro
/**
	Information about a type defined in any module.
**/
typedef DefinedType = {
	path: TypePath,
	pathString: String,
	complex: ComplexType
};
#end
