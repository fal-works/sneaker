package sneaker.log;

import haxe.PosInfos;
import sneaker.tag.Tag;

typedef LogFormat = (
	logType: LogType,
	message: String,
	tag: Tag,
	?pos: PosInfos
) -> String;
