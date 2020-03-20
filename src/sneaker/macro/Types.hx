package sneaker.macro;

#if macro
using haxe.macro.TypeTools;
import haxe.macro.Expr;
import haxe.macro.Type.AbstractType;
import sneaker.types.Result;

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

/**
	Information about a module.
**/
typedef ModuleInfo = {
	path: String,
	name: String,
	packagePath: String,
	packages: Array<String>
}

/**
	Information about a type defined in any module.
**/
typedef DefinedType = {
	path: TypePath,
	pathString: String,
	complex: ComplexType
};

/**
	A kind of `Type.AbstractType` instance that hs `@:enum` metadata.
**/
@:forward
abstract EnumAbstractType(AbstractType) to AbstractType {
	/**
		@param abstractType `Type.AbstractType`
		@return `EnumAbstractType` value, or an error message if `:enum` metadata is missing.
	**/
	public static inline function fromAbstractType(
		abstractType: AbstractType
	): Result<EnumAbstractType, String> {
		return if (abstractType.meta.has(":enum"))
			Ok(new EnumAbstractType(abstractType))
		else
			failed;
	}

	/**
		@return The underlying `AbstractType` value.
	**/
	@:to public inline function toAbstractType(): AbstractType return this;

	/**
		@return `ComplexType` value.
	**/
	@:to public inline function toComplexType(): ComplexType return this.type.toComplexType();

	static final failed: Result<EnumAbstractType, String> = Failed('Missing @:enum metadata');

	inline function new(abstractType: AbstractType)
		this = abstractType;
}
#end
