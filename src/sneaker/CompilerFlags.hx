package sneaker;

import haxe.macro.Compiler;
import sneaker.macro.CompilerFlag;
import sneaker.format.NullableDynamicCallbacks;

/**
	Compiler flags for `sneaker` library that may be referred in runtime.
**/
class CompilerFlags {
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
		validate: NullableDynamicCallbacks.dynamicToOptionalInt,
		type: Mandatory(200)
	};

	/**
		`-D sneaker_macro_log_level`
	**/
	public static final macroLogLevel: CompilerFlag<Int> = {
		name: "sneaker_macro_log_level",
		getDefine: () -> Compiler.getDefine("sneaker_macro_log_level"),
		validate: NullableDynamicCallbacks.dynamicToOptionalInt,
		type: Mandatory(300)
	};

	/**
		`-D sneaker_macro_message_level`
	**/
	public static final macroMessageLevel: CompilerFlag<Int> = {
		name: "sneaker_macro_message_level",
		getDefine: () -> Compiler.getDefine("sneaker_macro_message_level"),
		validate: NullableDynamicCallbacks.dynamicToOptionalInt,
		type: Mandatory(300)
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
