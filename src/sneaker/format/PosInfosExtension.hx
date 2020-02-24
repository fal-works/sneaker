package sneaker.format;

import haxe.PosInfos;

@:nullSafety(Strict)
class PosInfosExtension {
	static final noPositionInfo = "(No position info)";

	public static function formatClassMethod(pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.className}::${pos.methodName}';
	}

	public static function formatClassMethodLine(pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.className}::${pos.methodName} line ${pos.lineNumber}';
	}

	public static function formatFileLine(pos:Null<PosInfos>) {
		return pos == null ? noPositionInfo : '${pos.fileName} line ${pos.lineNumber}';
	}
}
