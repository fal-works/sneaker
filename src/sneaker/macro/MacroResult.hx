package sneaker.macro;

#if macro
import haxe.PosInfos;
import haxe.macro.Expr.Position;

/**
	Type that represents either success (`Ok`) or failure (`Failed`).
**/
@:using(sneaker.macro.MacroResult.MacroResultExtension)
enum MacroResult<T> {
	Ok(value: T);
	Failed(message: String, position: Position);
}

class MacroResultExtension {
	/**
		@return `true` if `this` is `Ok`.
	**/
	public static function isOk<T>(_this: MacroResult<T>): Bool {
		return switch _this {
			case Ok(_): true;
			case Failed(_, _): false;
		}
	}

	/**
		@return `true` if `this` is `Failed`.
	**/
	public static function isFailed<T>(_this: MacroResult<T>): Bool
		return !isOk(_this);

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

	/**
		@return The value if `Ok`. Outputs error if `Failed`.
	**/
	public static function unwrap<T>(_this: MacroResult<T>, ?pos: PosInfos): T {
		return switch _this {
			case Ok(value): value;
			case Failed(value, position):
				MacroLogger.error(value, position, pos);
				throw value;
		}
	}
}
#end
