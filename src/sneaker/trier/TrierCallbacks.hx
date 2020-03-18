package sneaker.trier;

import sneaker.log.LogLevel;
#if macro
import sneaker.macro.MacroLogger;
#else
import sneaker.log.LogTypes;
#end

/**
	Built-in callback functions for initializing `Trier.onFail()`.
**/
class TrierCallbacks {
	/**
		@return Function for initializing `Trier.onFail()`, either build-in or custom.
	**/
	public static function getOnFail(type: OnFailType): OnFailCallback {
		return switch type {
			case None: onFailEmpty;
			case Log(level):
				switch level {
					case Fatal: onFailFatal;
					case Error: onFailError;
					case Warn: onFailWarn;
					case Info: onFailInfo;
					case Debug: onFailDebug;
				}
			case Custom(callback): callback;
		}
	}

	static function createOnFailLog(level: LogLevel): OnFailCallback {
		#if !macro
		final logType = LogTypes.get(level);
		return function(message, ?tag, ?pos) {
			logType.print(message, null, pos);
		}
		#else
		final log = MacroLogger.getLogFunction(level);
		return function(message, ?tag, ?pos) log(message, pos);
		#end
	}

	static final onFailEmpty: OnFailCallback = function(message, ?tag, ?pos) {};

	static final onFailFatal = createOnFailLog(Fatal);
	static final onFailError = createOnFailLog(Error);
	static final onFailWarn = createOnFailLog(Warn);
	static final onFailInfo = createOnFailLog(Info);
	static final onFailDebug = createOnFailLog(Debug);
}
