package sneaker.assertion;

import haxe.PosInfos;
import haxe.CallStack;
import haxe.ds.Option;

/**
 * Exception raised by assertion failures.
 */
@:nullSafety(Strict)
class AssertionException extends sneaker.types.Exception {
	public final result:AssertionResult;
	public final posInfos:Option<PosInfos>;

	public function new(result:AssertionResult, ?pos:PosInfos) {
		this.result = result;
		this.posInfos = if (pos != null) Some(pos) else None;

		final currentCallStack = CallStack.callStack();
		currentCallStack.shift();

		final logString = Asserter.failureLogType.createLogString(Std.string(result), result.tag, pos);
		super(logString, currentCallStack);
	}
}
