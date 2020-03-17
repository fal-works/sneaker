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
		@return The value if `Ok`. Throws value if `Failed`.
	**/
	public static inline function unwrap<T, E>(_this: Result<T, E>): T {
		return switch _this {
			case Ok(value): value;
			case Failed(value): throw value;
		}
	}
}
