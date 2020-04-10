package sneaker.macro;

#if macro
import haxe.macro.Type;
import haxe.macro.Expr;
import sneaker.macro.Types.MacroModule;

using haxe.macro.ExprTools;
using sneaker.macro.MacroCaster;
using sneaker.macro.extensions.ClassTypeExtension;

class ContextTools {
	/**
		`MacroResult` version of `Context.getLocalClass()`.
		@return The current class in which the macro was called.
	**/
	public static function getLocalClassRef(): MacroResult<haxe.macro.Type.Ref<ClassType>> {
		final localClassRef = Context.getLocalClass();

		return if (localClassRef != null)
			Ok(localClassRef);
		else
			Failed('Failed to get local class', Context.currentPos());
	}

	/**
		`MacroResult` version of `Context.getLocalClass()`.
		@return The current class in which the macro was called.
	**/
	public static function getLocalClass(): MacroResult<ClassType> {
		final localClassRef = Context.getLocalClass();

		return if (localClassRef != null)
			Ok(localClassRef.get());
		else
			Failed('Failed to get local class', Context.currentPos());
	}

	/**
		@return Current file path, e.g. "src/Main.hx".
	**/
	public static inline function getFilePath(): String {
		final position = Context.getPosInfos(Context.currentPos());
		return '${position.file}';
	}

	/**
		@return `haxe.macro.Type` instance.
		If not found, `null` instead of throwing exception.
	**/
	public static function tryGetType(typePath: String): Null<Type> {
		try {
			return Context.getType(typePath);
		} catch (e:Dynamic) {
			return null;
		}
	}

	/**
		@return Array of all contained types.
		If module not found, `null` instead of throwing exception.
	**/
	public static function tryGetModule(modulePath: String): Null<MacroModule> {
		try {
			return Context.getModule(modulePath);
		} catch (e:Dynamic) {
			return null;
		}
	}

	/**
		Resolves `typeExpression` as a class.
		If `requiredInterfaceModulePath` is provided, also checks that the class implements that interface.
		@return `Type` and `ClassType` representations, or error message if failed.
	**/
	public static function resolveClassType(
		typeExpression: Expr,
		?requiredInterfaceModulePath: String,
		?requiredInterfaceName: String
	): MacroResult<{type: Type, classType: ClassType }> {
		final typeString = typeExpression.toString();
		final position = typeExpression.pos;

		final type = ContextTools.tryGetType(typeString);
		if (type == null)
			return Failed('Type not found: $typeString', position);

		final maybeClassType = type.toClassType();
		if (maybeClassType.isNone())
			return Failed('Failed to resolve type as a class', position);
		final classType = maybeClassType.unwrap();

		if (requiredInterfaceModulePath != null) {
			if (!classType.implementsInterface(
				requiredInterfaceModulePath,
				requiredInterfaceName
			)) {
				final name = if (requiredInterfaceName != null)
					'$requiredInterfaceModulePath.$requiredInterfaceName'
				else
					requiredInterfaceModulePath;

				return Failed(
					'Required a class implementing `$name` interface',
					position
				);
			}
		}

		return Ok({
			type: type,
			classType: classType
		});
	}
}
#end
