package sneaker.format;

import haxe.CallStack.StackItem;
import sneaker.format.CallStackItemFormat.*;

class CallStackItemExtension {
	static inline final twoSpaces = "  ";

	/**
	 * Formats `item` and returns a `String` representation.
	 *
	 * The formatting can be customized by changing values of static variables in `CallStackItemExtension`.
	 */
	public static function format(?item: StackItem): String {
		return switch (item) {
			case null:
				"null";
			case CFunction:
				Std.string(item);
			case Module(m):
				formatModule(m);
			case FilePos(s, file, line, column):
				formatFilePos(s, file, line, column);
			case Method(className, methodName):
				formatMethod(className, methodName);
			case LocalFunction(v):
				formatLocalFunction(v);
		}
	}

	/**
	 * Formats Call Stack.
	 * @return `String` representation of `stack`.
	 */
	public static function formatStack(stack: Array<StackItem>): String {
		return stack.map(format).join("\n");
	}

	/**
	 * Formats Call Stack with indent.
	 * @return `String` representation of `stack`.
	 */
	public static function formatStackIndent(stack: Array<StackItem>, indent = twoSpaces): String {
		final separator = '\n${indent}';

		final buffer = new StringBuf();
		buffer.add(indent);
		buffer.add(stack[0]);

		for (i in 1...stack.length) {
			buffer.add(separator);
			buffer.add(stack[i]);
		}

		return buffer.toString();
	}
}
