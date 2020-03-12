package sneaker.macro;

import haxe.ds.Option;
#if macro
import haxe.macro.Context;
import haxe.macro.Compiler;
#end

/**
	@see Field `CompilerFlag.type`
**/
enum CompilerFlagType<T> {
	Mandatory(defaultValue: T);
	Optional(nullValue: T);
}

/**
	Object unit representing a compiler flag, which
	- manages the default value,
	- holds the actual value and
	- provides same API both in macro and non-macro context
**/
@:structInit
class CompilerFlag<T> {
	/**
		The key string of the flag.
	**/
	final name: String;

	/**
		Function that gets the defined value by `Compiler.getDefine()`.
		`getDefine()` accepts only `String` literal, hence a clojure here.
		Used in non-macro context.
	**/
	final getDefine: () -> Null<Dynamic>;

	/**
		Function that tries to convert the `Dynamic` value to a valid & typed value.
		If a given value is invalid, this should return `None`.
	**/
	final validate: (define: Null<Dynamic>) -> Option<T>;

	/**
		Type of compiler flag.
		Affects to whether or not to register the default value by `Compiler.define()`
		in the initialization macro if the flag is not defined.
	**/
	final type: CompilerFlagType<T>;

	/**
		Internal variable for holding the actually defined value of the flag.
	**/
	@:noPrivateAccess
	var value: Option<T> = None;

	public function new(
		name: String,
		getDefine: () -> Null<Dynamic>,
		validate: (define: Null<Dynamic>) -> Option<T>,
		type: CompilerFlagType<T>
	) {
		this.name = name;
		this.getDefine = getDefine;
		this.validate = validate;
		this.type = type;
	}

	/**
		Gets the defined value.
		At the first call it saves the value in `this` object internally.
	**/
	public function get(): T {
		return switch value {
			case Some(validValue): validValue;
			case None: set();
		}
	}

	/**
		Queries the defined value and saves it internally.

		In macro context, it should be called from the initialization macro so that
		it defines the default value if the flag is not yet defined (or invalid)
		and the `type` is `Mandatory`.
	**/
	#if macro
	public
	#end
	function set(): T {
		final define = #if macro Context.definedValue(name); #else getDefine(); #end
		final validated = validate(define);

		return switch (validate(define)) {
			case Some(validValue):
				this.value = validated;
				validValue;
			case None:
				switch type {
					case Mandatory(defaultValue):
						#if macro
						Compiler.define(name, '$defaultValue');
						#end
						this.value = Some(defaultValue);
						defaultValue;
					case Optional(nullValue):
						this.value = Some(nullValue);
						nullValue;
				}
		}
	}
}
