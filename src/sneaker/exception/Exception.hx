package sneaker.exception;

import sneaker.format.CallStackItemExtension;
import haxe.CallStack;
import haxe.CallStack.StackItem;

/**
 * Base exception class.
 */
@:nullSafety(Strict)
class Exception {
	public static var appendCallStack = true;

	public final content:Dynamic;
	public final callStack:Array<StackItem>;

	public function new(content:Dynamic, ?callStack:Array<StackItem>) {
		this.content = content;

		if (callStack != null) {
			this.callStack = callStack;
		} else if (appendCallStack) {
			final currentCallStack = CallStack.callStack();
			currentCallStack.shift();
			this.callStack = currentCallStack;
		} else {
			this.callStack = [];
		}
	}

	public function toString():String {
		if (appendCallStack)
			return '${content}\n\nCall Stack:\n${callStack.map(CallStackItemExtension.format).join("\n")}';
		else
			return content;
	}
}
