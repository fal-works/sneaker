package sneaker.assertion;

import haxe.CallStack;

/**
 * Exception raised by assertion failures.
 */
@:nullSafety(Strict)
class AssertionException extends sneaker.types.Exception {
	public final result:AssertionResult;

	public function new(result:AssertionResult) {
		this.result = result;

		final currentCallStack = CallStack.callStack();
		currentCallStack.shift();

		super(result.createLogString(Asserter.failureLogType), currentCallStack, result.positionInformations);
	}
}
