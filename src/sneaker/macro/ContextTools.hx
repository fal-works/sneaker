package sneaker.macro;

#if macro
import sneaker.macro.Types.MacroType;
import sneaker.macro.Types.MacroModule;
import haxe.macro.Type.ClassType;

class ContextTools {
	/**
		`MacroResult` version of `Context.getLocalClass()`.
		@return The current class in which the macro was called.
	**/
	public static function getLocalClass(): MacroResult<ClassType> {
		final localClassRef = Context.getLocalClass();

		return if (localClassRef != null)
			Ok(localClassRef.get());
		else
			Failed(
				'Failed to get local class',
				Context.currentPos()
			);
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
	public static function tryGetType(typePath: String): Null<MacroType> {
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
}
#end
