package sneaker.assertion;

import haxe.CallStack;
import sneaker.exception.Exception;

/**
	Exception raised by assertion failures.
**/
class AssertionException extends Exception {
	/**
		Detailed information about the assertion that raised `this` exception.
	**/
	public final result: AssertionResult;

	public function new(result: AssertionResult) {
		this.result = result;

		final currentCallStack = CallStack.callStack();
		currentCallStack.shift();

		super(
			result.createLogString(AsserterSettings.failureLogType),
			currentCallStack,
			null,
			result.positionInformations
		);
	}
}
