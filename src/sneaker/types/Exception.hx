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
	 * is appended to the content in `toString()`.
	 *
	 * The format can be customized in `sneaker.format.CallStackItemFormat`.
	 */
	public var appendCallStack: Bool;

	public final content: Dynamic;
	public final callStack: Array<StackItem>;
	public final positionInformation: Null<PosInfos>;

	/**
	 * Creates an exception instance.
	 * @param content Value to be appended after the exception class name in `toString()`.
	 * @param appendCallStack If `true` (default), call stack is appended after `content` in `toString()`.
	 * @param callStack If not provided, the call stack is saved automatically in `Exception.new()`.
	 * @param pos No effect, but you can pass any position info for your own purpose.
	 */
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
