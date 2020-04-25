package sneaker.trier;

#if macro
import haxe.macro.Context;
import haxe.macro.Expr.Error;
#else
import sneaker.exception.Exception;
#end

/**
	Functions internally used in `trier` package.
**/
class TrierResultTools {
	/**
		@param failed Just to avoid doing `switch` check again.
	**/
	public static inline function build<R>(
		result: Result<R>,
		failed: Bool
	): TrierResult<R> {
		#if eval
		return {
			result: result,
			failed: failed,
			unwrap: TrierResultTools.unwrap.bind(result, _, _),
			unwrapFailure: TrierResultTools.unwrapFailure.bind(result, _, _)
		};
		#else
		return new TrierResult(result, failed);
		#end
	}

	/**
		@return The actual value. Throws error if failed.
	**/
	public static inline function unwrap<R>(
		result: Result<R>,
		?tag: Tag,
		?pos: PosInfos
	): R {
		return switch (result) {
			case Ok(resultValue):
				resultValue;
			case Failed(message):
				#if macro
				throw new Error(message, Context.currentPos());
				#else
				throw new Exception(message, null, null, pos);
				#end
		}
	}

	/**
		@return The failure message. Throws error if the process did not fail.
	**/
	public static inline function unwrapFailure<R>(
		result: Result<R>,
		?tag: Tag,
		?pos: PosInfos
	): String {
		return switch (result) {
			case Ok(_):
				final message = "Cannot unwrap failure message because the result is Ok.";
				#if macro
				throw new Error(message, Context.currentPos());
				#else
				throw new Exception(message, null, null, pos);
				#end
			case Failed(message):
				message;
		}
	}
}
