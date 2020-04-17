package sneaker.types;

/**
	Type that represents either success (`Ok`) or failure (`Failed`).
**/
@:using(sneaker.types.Result.ResultExtension)
enum Result<T, E> {
	Ok(value: T);
	Failed(value: E);
}

class ResultExtension {
	/**
		@return `true` if `this` is `Ok`.
	**/
	public static extern inline function isOk<T, E>(_this: Result<T, E>): Bool {
		return switch _this {
			case Ok(_): true;
			case Failed(_): false;
		}
	}

	/**
		@return `true` if `this` is `Failed`.
	**/
	public static extern inline function isFailed<T, E>(_this: Result<T, E>): Bool
		return !isOk(_this);

	/**
		@return The value if `Ok`. Throws value if `Failed`.
	**/
	public static extern inline function unwrap<T, E>(_this: Result<T, E>): T {
		return switch _this {
			case Ok(value): value;
			case Failed(value): throw value;
		}
	}
}
