package sneaker.log;

import haxe.macro.Compiler;
#if macro
import haxe.macro.Context;
#end

class Constants {
	/**
		The value of compiler flag `sneaker_log_level`.
	**/
	@:noPrivateAccess
	public static var logLevelThreshold(get, null): Int = defaultLogLevelThreshold;

	static inline final defaultLogLevelThreshold = 200;
	static inline final logLevelDefineName = "sneaker_log_level";
	static var logLevelInitialized = false;

	static inline function dynamicToInt(value: Null<Dynamic>): Null<Int>
		return if (value == null) null else Std.parseInt(Std.string(value));

	static inline function get_logLevelThreshold() {
		if (!logLevelInitialized) {
			final define = dynamicToInt(Compiler.getDefine("sneaker_log_level"));
			if (define != null) logLevelThreshold = define;
			logLevelInitialized = true;
		}

		return logLevelThreshold;
	}

	#if macro
	/**
		Sets default value for compiler flag `sneaker_log_level` if not defined.
		Called from the initialization macro of sneaker.
	**/
	@:allow(sneaker.Initialization)
	static function ensureLogLevelDefine() {
		final logLevelDefine = dynamicToInt(Context.definedValue(logLevelDefineName));

		if (logLevelDefine == null)
			Compiler.define(logLevelDefineName, '$defaultLogLevelThreshold');
	}
	#end
}
