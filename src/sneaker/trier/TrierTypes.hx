package sneaker.trier;

import sneaker.log.LogLevel;

/**
	Type alias for `Trier::onFail()`.
**/
// @formatter:off
typedef OnFailCallback = (message: String, ?tag: Tag, ?pos: PosInfos) -> Void;
// @formatter:on
//

/**
	Option keys for initializing `Trier::onFail()`.
**/
enum OnFailType {
	None;
	Log(level: LogLevel);
	Custom(callback: OnFailCallback);
}
