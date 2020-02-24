package sneaker.format;

using sneaker.format.StringExtension;

import haxe.CallStack.StackItem;

@:nullSafety(Strict)
class CallStackItemExtension {
	public static var hideFilePath = false;
	public static var hideModulePath = true;
	public static var separator = " ";

	@:noUsing public static var formatLineColumn = (line:Int, column:Null<Int>) -> {
		return 'line ${line}${column != null ? ", col " + column : ""}';
	};

	@:noUsing public static var formatModule = (module:String) -> module;

	@:noUsing public static var formatFilePos = (s:Null<StackItem>, file:String, line:Int, column:Null<Int>) -> {
		return '${hideFilePath ? "" : file}${separator}${format(s)}${separator}${formatLineColumn(line, column)}';
	};

	@:noUsing public static var formatClass = (?className:String) -> {
		return className != null ? '${hideModulePath ? className.sliceAfterLastDot() : className}' : "?";
	};

	@:noUsing public static var formatMethod = (?className:String, methodName:String) -> {
		return '${formatClass(className)}::${methodName}';
	};

	@:noUsing public static var formatLocalFunction = (v:Null<Int>) -> 'fn ${v}';

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
