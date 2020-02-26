package sneaker.format;

using sneaker.format.StringExtension;

import haxe.PosInfos;

class PosInfosExtension {
	static final noPositionInfo = "(No position info)";

	/** Example: "mydirectory/MyFile.hx" */
	public static function formatFile(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.fileName}';
	}
	/** Example: "my_module.MyClass" */
	public static function formatClass(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.className}';
	}
	/** Example: "myMethod" */
	public static function formatMethod(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.methodName}';
	}

	/** Example: "MyClass" */
	public static function formatClassWithoutModule(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.className.sliceAfterLastDot()}';
	}
	/** Example: "my_module.MyClass::myMethod" */
	public static function formatClassMethod(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.className}::${pos.methodName}';
	}
	/** Example: "MyClass::myMethod" */
	public static function formatClassMethodWithoutModule(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.className.sliceAfterLastDot()}::${pos.methodName}';
	}
	/** Example: "my_module.MyClass::myMethod line 1" */
	public static function formatClassMethodLine(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.className}::${pos.methodName} line ${pos.lineNumber}';
	}
	/** Example: "MyClass::myMethod line 1" */
	public static function formatClassMethodLineWithoutModule(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.className.sliceAfterLastDot()}::${pos.methodName} line ${pos.lineNumber}';
	}

	/** Example: "MyFile.hx" */
	public static function formatFileWithoutPath(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.fileName.sliceAfterLastSlash()}';
	}
	/** Example: "mydirectory/MyFile.hx line 1" */
	public static function formatFileLine(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.fileName} line ${pos.lineNumber}';
	}
	/** Example: "MyFile.hx line 1" */
	public static function formatFileLineWithoutPath(?pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.fileName.sliceAfterLastSlash()} line ${pos.lineNumber}';
	}
}
