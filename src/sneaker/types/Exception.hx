package sneaker.types;

import sneaker.format.CallStackItemExtension;
import haxe.CallStack;
import haxe.CallStack.StackItem;
import haxe.PosInfos;

/**
 * Base exception class.
 */
class Exception {
	/**
	 * If `true`, call stack information (saved at the instanciation)
	 * is appended to the content when casting an exception to `String`.
	 *
	 * The format can be customized in `sneaker.format.CallStackItemFormat`.
	 */
	public var appendCallStack: Bool;

	public final content: Dynamic;
	public final callStack: Array<StackItem>;
	public final positionInformation: Null<PosInfos>;

	public function new(
		content: Dynamic,
		appendCallStack = true,
		?callStack: Array<StackItem>,
		?pos: PosInfos
	) {
		this.content = content;
		this.appendCallStack = appendCallStack;

		if (callStack != null) {
			this.callStack = callStack;
		} else {
			final currentCallStack = CallStack.callStack();
			currentCallStack.shift();
			this.callStack = currentCallStack;
		}

		this.positionInformation = pos;
	}

	public function toString(): String {
		return if (appendCallStack)
			'${content}\n\nCall Stack:\n${callStack.map(CallStackItemExtension.format).join("\n")}';
		else
			content;
	}
}
