package sneaker.tag;

import haxe.PosInfos;
import sneaker.log.LogType;
import sneaker.log.Logger;
import sneaker.tag.interfaces.Tagged;

class TaggedExtension {
	/**
		Attaches a new `tag` to `this`.

		No effect if compilation flag `sneaker_tagged_disable` is set.
		@return `this`
	**/
	public static extern inline function setTag<T: Tagged>(_this: T, tag: Tag): T {
		#if !sneaker_tagged_disable
		_this.tag = tag;
		#end
		return _this;
	}

	/**
		A shortcut for `this.tag = new Tag(name, bits)`.

		No effect if compilation flag `sneaker_tagged_disable` is set.
		@return `this`
	**/
	public static extern inline function newTag<T: Tagged>(
		_this: T,
		name: String,
		?bits: Int
	): T {
		#if !sneaker_tagged_disable
		_this.tag = new Tag(name, bits);
		#end
		return _this;
	}

	/**
		Output `message` as a log of any `logType`.
	**/
	public static extern inline function log(
		_this: Tagged,
		logType: LogType,
		message: String,
		?pos: PosInfos
	): Void {
		logType.print(message, _this.tag, pos);
	}

	/**
		Prints FATAL log. Mainly for severe errors.

		Has effect only under the compilation condition `sneaker_log_level >= 100`.

		Default log types: [ FATAL ] - ERROR - WARN - INFO - DEBUG
	**/
	public static extern inline function fatal(
		_this: Tagged,
		message: String,
		?pos: PosInfos
	): Void {
		Logger.fatal(message, _this.tag, pos);
	}

	/**
		Prints ERROR log. Mainly for general errors or unexpected conditions.

		Has effect only under the compilation condition `sneaker_log_level >= 200`.

		Default log types: FATAL - [ ERROR ]  - WARN - INFO - DEBUG
	**/
	public static extern inline function error(
		_this: Tagged,
		message: String,
		?pos: PosInfos
	): Void {
		Logger.error(message, _this.tag, pos);
	}

	/**
		Prints WARN log.
		Mainly for events or situations that are unexpected, but not necessarily "wrong".

		Has effect only under the compilation condition `sneaker_log_level >= 300`.

		Default log types: FATAL - ERROR - [ WARN ] - INFO - DEBUG
	**/
	public static extern inline function warn(
		_this: Tagged,
		message: String,
		?pos: PosInfos
	): Void {
		Logger.warn(message, _this.tag, pos);
	}

	/**
		Prints INFO log.
		Mainly for interesting runtime events (e.g. startup, initialization, ...)

		Has effect only under the compilation condition `sneaker_log_level >= 400`.

		Default log types: FATAL - ERROR - WARN - [ INFO ] - DEBUG
	**/
	public static extern inline function info(
		_this: Tagged,
		message: String,
		?pos: PosInfos
	): Void {
		Logger.info(message, _this.tag, pos);
	}

	/**
		Prints DEBUG log. Mainly for detailed information.

		Has effect only under the compilation condition `sneaker_log_level >= 500`.

		Default log types: FATAL - ERROR - WARN - INFO - [ DEBUG ]
	**/
	public static extern inline function debug(
		_this: Tagged,
		message: String,
		?pos: PosInfos
	): Void {
		Logger.debug(message, _this.tag, pos);
	}
}
