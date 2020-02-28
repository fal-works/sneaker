package sneaker.common;

import haxe.CallStack;
import haxe.CallStack.StackItem;
import haxe.PosInfos;

/**
 * Base exception class.
 */
class Exception {
	/**
	 * If `true`, call stack information (saved at the instanciation)
	 * is appended to the content in `toString()`.
	 *
	 * Turn on/off depending on your situation, e.g. set to `true` in a `catch {}` block.
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
	 * @param callStack If not provided, the call stack is saved automatically in `Exception.new()`.
	 * @param appendCallStack If `true`, call stack is appended after `content` in `toString()`.
	 * @param pos No effect, but you can pass any position info for your own purpose.
	 */
	public function new(
		content: Dynamic,
		?callStack: Array<StackItem>,
		?appendCallStack,
		?pos: PosInfos
	) {
		this.content = content;
		this.appendCallStack = if (appendCallStack != null)
			appendCallStack
		else
			ExceptionSettings.appendCallStackDefault;

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
			'${name}\n${content}\nCall Stack:\n${ExceptionSettings.callStackFormat(callStack)}';
		else
			'${name}\n${content}';
	}
}
