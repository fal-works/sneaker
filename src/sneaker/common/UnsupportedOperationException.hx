package sneaker.common;

import haxe.CallStack;
import haxe.PosInfos;

/**
	Exception raised from functions/methods that are not supported.
**/
class UnsupportedOperationException extends Exception {
	/**
		@param appendCallStack If `true`, call stack is appended after `content` in `toString()`.
	**/
	public function new(
		message: String,
		?appendCallStack,
		?pos: PosInfos
	) {
		final currentCallStack = CallStack.callStack();
		currentCallStack.shift();

		super(message, currentCallStack, appendCallStack, pos);
	}
}
