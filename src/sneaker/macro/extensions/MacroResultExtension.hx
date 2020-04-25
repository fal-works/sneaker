package sneaker.macro.extensions;

#if macro
import prayer.MacroResult;

class MacroResultExtension {
	/**
		Warns is `this` is `Failed`.
		@return `true` if `this` is `Failed`.
	**/
	public static function isFailedWarn<T>(_this: MacroResult<T>): Bool {
		return switch _this {
			case Ok(_): false;
			case Failed(value, position):
				MacroLogger.warn(value, position);
				true;
		}
	}
}
#end
