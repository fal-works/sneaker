package sneaker.format;

import haxe.CallStack.StackItem;
import sneaker.format.CallStackItemFormat.*;

@:nullSafety(Strict)
class CallStackItemExtension {
	/**
	 * Formats `item` and returns a `String` representation.
	 *
	 * The formatting can be customized by changing values of static variables in `CallStackItemExtension`.
	 */
	public static function format(?item:StackItem):String {
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
}
