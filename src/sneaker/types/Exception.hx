package sneaker.types;

import haxe.CallStack;
import haxe.CallStack.StackItem;
import haxe.PosInfos;
import sneaker.format.CallStackItemCallbacks;

/**
 * Base exception class.
 */
class Exception {
	/**
	 * Formatting function used when casting an exception to `String`.
	 * Can be replaced with any custom function.
	 */
	public static var callStackFormat = CallStackItemCallbacks.formatStackIndent.bind(_);

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
		final name = Type.getClassName(Type.getClass(this));

		return if (appendCallStack)
			'${name}\n${content}\nCall Stack:\n${callStackFormat(callStack)}';
		else
			'${name}\n${content}';
	}
}
