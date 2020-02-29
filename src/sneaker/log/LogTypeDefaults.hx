package sneaker.log;

import haxe.PosInfos;
import sneaker.tag.Tag;
import sneaker.format.PosInfosCallbacks;

/**
	Values that will be assigned when creating a new `LogType` instance.
	Can also be replaced with custom functions.
**/
class LogTypeDefaults {
	public static var tagFilter = (tag: Tag) -> true;
	public static var positionFilter = (?pos: PosInfos) -> true;

	public static var positionFormat = PosInfosCallbacks.formatClassMethodLine;
	public static var logFormat = LogFormats.prefixPositionTagMessage;
}
