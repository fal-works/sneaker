package sneaker.log;

import haxe.PosInfos;
import sneaker.tag.Tag;
import sneaker.log.LogTypes;

@:nullSafety(Strict)
class Log {
	/**
	 * Prints log of any `logType`.
	 */
	public static inline function log(logType:LogType, message:String, ?tag:Tag, ?pos:PosInfos) {
		logType.print(message, tag, pos);
	}

	/**
	 * Prints FATAL log. Mainly for severe errors.
	 *
	 * Has effect only under the compilation condition `sneaker_log_level >= 100`.
	 *
	 * Default log types: [ FATAL ] - ERROR - WARN - INFO - DEBUG
	 */
	public static inline function fatal(message:String, ?tag:Tag, ?pos:PosInfos) {
		#if (sneaker_log_level >= 100)
		LogTypes.fatal.print(message, tag, pos);
		#end
	}

	/**
	 * Prints ERROR log. Mainly for general errors or unexpected conditions.
	 *
	 * Has effect only under the compilation condition `sneaker_log_level >= 200`.
	 *
	 * Default log types: FATAL - [ ERROR]  - WARN - INFO - DEBUG
	 */
	public static inline function error(message:String, ?tag:Tag, ?pos:PosInfos) {
		#if (sneaker_log_level >= 200)
		LogTypes.error.print(message, tag, pos);
		#end
	}

	/**
	 * Prints WARN log.
	 * Mainly for events or situations that are unexpected, but not necessarily "wrong".
	 *
	 * Has effect only under the compilation condition `sneaker_log_level >= 300`.
	 *
	 * Default log types: FATAL - ERROR - [ WARN ] - INFO - DEBUG
	 */
	public static inline function warn(message:String, ?tag:Tag, ?pos:PosInfos) {
		#if (sneaker_log_level >= 300)
		LogTypes.warn.print(message, tag, pos);
		#end
	}

	/**
	 * Prints INFO log.
	 * Mainly for interesting runtime events (e.g. startup, initialization, ...)
	 *
	 * Has effect only under the compilation condition `sneaker_log_level >= 400`.
	 *
	 * Default log types: FATAL - ERROR - WARN - [ INFO ] - DEBUG
	 */
	public static inline function info(message:String, ?tag:Tag, ?pos:PosInfos) {
		#if (sneaker_log_level >= 400)
		LogTypes.info.print(message, tag, pos);
		#end
	}

	/**
	 * Prints DEBUG log. Mainly for detailed information.
	 *
	 * Has effect only under the compilation condition `sneaker_log_level >= 500`.
	 *
	 * Default log types: FATAL - ERROR - WARN - INFO - [ DEBUG ]
	 */
	public static inline function debug(message:String, ?tag:Tag, ?pos:PosInfos) {
		#if (sneaker_log_level >= 500)
		LogTypes.debug.print(message, tag, pos);
		#end
	}
}
