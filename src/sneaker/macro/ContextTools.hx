package sneaker.macro;

#if macro
import sneaker.macro.Types.MacroType;
import sneaker.macro.Types.MacroModule;

class ContextTools {
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
		}
		catch(e: Dynamic) {
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
		}
		catch(e: Dynamic) {
			return null;
		}
	}
}
#end
