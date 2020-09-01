package sneaker;

import haxe.macro.Compiler;
import prayer.CompilerFlag;

/**
	Compiler flags for `sneaker` library that may be referred in runtime.
**/
class CompilerFlags {
	static final parseIntOptional = (s: Null<Dynamic>) -> {
		return @:nullSafety(Off) Nulls.parseIntOptional(s);
	};

	/**
		`-D sneaker_print_disable`
	**/
	public static final printDisable: CompilerFlag<Bool> = {
		name: "sneaker_print_disable",
		getDefine: () -> Compiler.getDefine("sneaker_print_disable"),
		validate: define -> Some(define != null),
		type: Optional(false)
	};

	/**
		`-D sneaker_log_level`
	**/
	public static final logLevel: CompilerFlag<Int> = {
		name: "sneaker_log_level",
		getDefine: () -> Compiler.getDefine("sneaker_log_level"),
		validate: parseIntOptional,
		type: Mandatory(#if debug 500 #else 200 #end)
	};

	/**
		`-D sneaker_macro_log_level`
	**/
	public static final macroLogLevel: CompilerFlag<Int> = {
		name: "sneaker_macro_log_level",
		getDefine: () -> Compiler.getDefine("sneaker_macro_log_level"),
		validate: parseIntOptional,
		type: Mandatory(#if debug 500 #else 300 #end)
	};

	/**
		`-D sneaker_macro_message_level`
	**/
	public static final macroMessageLevel: CompilerFlag<Int> = {
		name: "sneaker_macro_message_level",
		getDefine: () -> Compiler.getDefine("sneaker_macro_message_level"),
		validate: parseIntOptional,
		type: Mandatory(#if debug 500 #else 300 #end)
	};

	#if macro
	/**
		Initializes compiler flags and set default values if needed.
		Can only be called from the initialization macro.
	**/
	@:allow(sneaker.Initialization)
	static function initialize() {
		printDisable.set();
		logLevel.set();
		macroLogLevel.set();
		macroMessageLevel.set();
	}
	#end
}
