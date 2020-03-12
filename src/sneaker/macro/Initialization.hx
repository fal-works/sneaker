package sneaker.macro;

#if macro
import haxe.macro.Context;
import haxe.macro.Compiler;

/**
	Initialization macro for `sneaker.macro` package.
**/
class Initialization {
	static inline final defaultLogLevelThreshold = 300;
	static inline final logLevelDefineName = "sneaker_macro_log_level";

	static inline final defaultMessageLevelThreshold = 300;
	static inline final messageLevelDefineName = "sneaker_macro_message_level";

	static inline function dynamicToInt(value: Null<Dynamic>): Null<Int>
		return if (value == null) null else Std.parseInt(Std.string(value));

	/**
		Sets default value for compiler flag `sneaker_macro_log_level` if not defined.
		Called from the initialization macro of sneaker.
	**/
	@:allow(sneaker.Initialization)
	static function ensureLogLevelDefine() {
		final logLevelDefine = dynamicToInt(Context.definedValue(logLevelDefineName));

		if (logLevelDefine == null)
			Compiler.define(logLevelDefineName, '$defaultLogLevelThreshold');
	}

	/**
		Sets default value for compiler flag `sneaker_macro_message_level` if not defined.
		Called from the initialization macro of sneaker.
	**/
	@:allow(sneaker.Initialization)
	static function ensureMessageLevelDefine() {
		final messageLevelDefine = dynamicToInt(Context.definedValue(messageLevelDefineName));

		if (messageLevelDefine == null)
			Compiler.define(messageLevelDefineName, '$defaultMessageLevelThreshold');
	}
}
#end
