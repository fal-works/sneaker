package sneaker.trier;

import sneaker.types.Result;
#if macro
import haxe.macro.Expr.Error;
import sneaker.macro.PositionStack;
#else
import sneaker.exception.Exception;
#end

#if eval
typedef TrierResult<R> = {
	public final result: Result<R, String>;
	public final failed: Bool;
	public function unwrap(?tag: Tag, ?pos: PosInfos): R;
}
#else
class TrierResult<R> {
	public final result: Result<R, String>;
	public final failed: Bool;

	public function new(result: Result<R, String>) {
		this.result = result;
		this.failed = result.isFailed();
	}

	public inline function unwrap(?tag: Tag, ?pos: PosInfos): R
		return TrierResultTools.unwrap(this.result, tag, pos);
}
#end

class TrierResultBuilder {
	public static function build<R>(result: Result<R, String>): TrierResult<R> {
		#if eval
		return {
			result: result,
			failed: result.isFailed(),
			unwrap: TrierResultTools.unwrap.bind(result, _, _)
		};
		#else
		return new TrierResult(result);
		#end
	}
}

class TrierResultTools {
	public static inline function unwrap<R>(result: Result<R, String>, ?tag: Tag, ?pos: PosInfos): R {
		return switch (result) {
			case Ok(resultValue):
				resultValue;
			case Failed(message):
				#if macro
				// error() may or may not stop macro depending on `sneaker_macro_message_level`
				throw new Error(message, PositionStack.peek());
				#else
				throw new Exception(message, null, null, pos);
				#end
		}
	}
}
