package sneaker.exception;

using sneaker.format.PosInfosExtension;

import haxe.CallStack;
import haxe.PosInfos;

/**
	Exception raised from methods that need to be overridden in subclasses but are not.
**/
class NotOverriddenException extends Exception {
	/**
		@param appendCallStack If `true`, call stack is appended after `content` in `toString()`.
	**/
	public function new(?appendCallStack, ?pos: PosInfos) {
		final currentCallStack = CallStack.callStack();
		currentCallStack.shift();

		final methodPosition = pos.formatClassMethod();

		super(
			'This method must be overridden by a subclass.\nPosition: ${methodPosition}',
			currentCallStack,
			appendCallStack,
			pos
		);
	}
}
