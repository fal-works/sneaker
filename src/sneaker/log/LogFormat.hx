package sneaker.log;

import haxe.PosInfos;
import sneaker.tag.Tag;

// @formatter:off

typedef LogFormat = (
	logType: LogType,
	message: String,
	tag: Tag,
	?pos: PosInfos
) -> String;
