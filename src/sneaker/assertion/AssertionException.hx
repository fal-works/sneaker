package sneaker.assertion;

import haxe.CallStack;
import sneaker.types.Exception;

/**
 * Exception raised by assertion failures.
 */
class AssertionException extends Exception {
	/**
	 * If `true`, call stack information is not appended
	 * when casting an `AssertionException` instance to `String`.
	 */
	public static var hideCallstack = false;

	/**
	 * Detailed information about the assertion that raised `this` exception.
	 */
	public final result: AssertionResult;

	public function new(result: AssertionResult) {
		this.result = result;

		final currentCallStack = CallStack.callStack();
		currentCallStack.shift();

		super(
			result.createLogString(Asserter.failureLogType),
			!hideCallstack,
			currentCallStack,
			result.positionInformations
		);
	}
}
