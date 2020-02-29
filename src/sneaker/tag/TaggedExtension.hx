package sneaker.tag;

import haxe.PosInfos;
import sneaker.log.LogType;
import sneaker.log.Logger;

// @formatter:off

class TaggedExtension {
	/**
		A shortcut for `thisObj.tag = new Tag(name, bits)`.

		No effect if compilation flag `sneaker_tagged_disable` is set.
	 **/
	public static inline function newTag(thisObj: Tagged, name: String, ?bits: Int) {
		#if !sneaker_tagged_disable
		thisObj.tag = new Tag(name, bits);
		#end
	}

	/**
		Output `message` as a log of any `logType`.
	 **/
	public static inline function log(thisObj: Tagged, logType: LogType, message: String, ?pos: PosInfos) {
		Logger.log(logType, message, thisObj.tag, pos);
	}

	/**
		Prints FATAL log. Mainly for severe errors.

		Has effect only under the compilation condition `sneaker_log_level >= 100`.

		Default log types: [ FATAL ] - ERROR - WARN - INFO - DEBUG
	 **/
	public static inline function fatal(thisObj: Tagged, message: String, ?pos: PosInfos) {
		Logger.fatal(message, thisObj.tag, pos);
	}

	/**
		Prints ERROR log. Mainly for general errors or unexpected conditions.

		Has effect only under the compilation condition `sneaker_log_level >= 200`.

		Default log types: FATAL - [ ERROR ]  - WARN - INFO - DEBUG
	 **/
	public static inline function error(thisObj: Tagged, message: String, ?pos: PosInfos) {
		Logger.error(message, thisObj.tag, pos);
	}

	/**
		Prints WARN log.
		Mainly for events or situations that are unexpected, but not necessarily "wrong".

		Has effect only under the compilation condition `sneaker_log_level >= 300`.

		Default log types: FATAL - ERROR - [ WARN ] - INFO - DEBUG
	 **/
	public static inline function warn(thisObj: Tagged, message: String, ?pos: PosInfos) {
		Logger.warn(message, thisObj.tag, pos);
	}

	/**
		Prints INFO log.
		Mainly for interesting runtime events (e.g. startup, initialization, ...)

		Has effect only under the compilation condition `sneaker_log_level >= 400`.

		Default log types: FATAL - ERROR - WARN - [ INFO ] - DEBUG
	 **/
	public static inline function info(thisObj: Tagged, message: String, ?pos: PosInfos) {
		Logger.info(message, thisObj.tag, pos);
	}

	/**
		Prints DEBUG log. Mainly for detailed information.

		Has effect only under the compilation condition `sneaker_log_level >= 500`.

		Default log types: FATAL - ERROR - WARN - INFO - [ DEBUG ]a
	 **/
	public static inline function debug(thisObj: Tagged, message: String, ?pos: PosInfos) {
		Logger.debug(message, thisObj.tag, pos);
	}
}
