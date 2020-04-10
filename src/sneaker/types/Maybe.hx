package sneaker.types;

import haxe.Constraints.Function;
#if !macro
import sneaker.assertion.Asserter.*;
#end

/**
	Wrapper of `Null<T>` for:
	- avoiding implicit boxing of primitive values
	- avoiding implicit unwrapping
	- adding some utility methods
**/
@:notNull
abstract Maybe<T>(Null<T>) {
	/**
		Casts any nullable value to `Maybe<T>`.
	**/
	public static inline function from<T>(value: Null<T>): Maybe<T>
		return new Maybe(value);

	/**
		Casts any object to `Maybe<T>`.
	**/
	@:from public static inline function fromObject<T: {}>(object: T): Maybe<T>
		return new Maybe(object);

	/**
		Casts any function to `Maybe<T>`.
	**/
	@:from public static inline function fromFunction<T: Function>(func: T): Maybe<T>
		return new Maybe(func);

	/**
		Casts `this` to `Null<T>`.
	**/
	public inline function toNullable(): Null<T>
		return this;

	/**
		@return `true` if not null.
	**/
	public inline function isSome(): Bool
		return this != null;

	/**
		@return `true` if null.
	**/
	public inline function isNone(): Bool
		return this == null;

	/**
		Unwraps `this` if not null. Otherwise returns `defaultValue`.
	**/
	public inline function or(defaultValue: T): T
		return if (this != null) this else defaultValue;

	/**
		Unwraps `this` if not null. Otherwise returns the result of `defaultFactory()`.
	**/
	public inline function orElse(defaultFactory: () -> T): T
		return if (this != null) this else defaultFactory();

	/**
		Runs `callback` only if `this` is not null.
	**/
	public inline function may(callback: T->Void): Void
		if (this != null) callback(this);

	/**
		Applies `callback` to `this` and returns another `Maybe` value.
	**/
	public inline function map<U>(callback: T->U): Maybe<U>
		return Maybe.from(if (this != null) callback(this) else null);

	/**
		Casts `this` to a non-null type.
	**/
	public inline function unwrap(): T {
		#if !macro
		assert(this != null);
		#end
		return this;
	}

	inline function new(data: Null<T>)
		this = data;
}
