package sneaker.types;

import haxe.ds.Option as StdOption;
import sneaker.exception.Exception;

/**
	Wrapper of `haxe.ds.Option` with some additional methods.
**/
@:notNull
abstract Option<T>(StdOption<T>) from StdOption<T> to StdOption<T> {
	/**
		@return `true` if `this` is `Some`.
	**/
	public extern inline function isSome(): Bool {
		return switch this {
			case Some(_): true;
			case None: false;
		}
	}

	/**
		@return `true` if `this` is `None`.
	**/
	public extern inline function isNone(): Bool {
		return switch this {
			case Some(_): false;
			case None: true;
		}
	}

	/**
		Casts `this` to `Null<T>`.
	**/
	public extern inline function toNullable(): Null<T> {
		return switch this {
			case Some(value): value;
			case None: null;
		}
	}

	/**
		Unwraps `this` if not null. Otherwise returns `defaultValue`.
	**/
	public extern inline function or(defaultValue: T): T {
		return switch this {
			case Some(value): value;
			case None: defaultValue;
		}
	}

	/**
		Unwraps `this` if not null. Otherwise returns the result of `defaultFactory()`.
	**/
	public extern inline function orElse(defaultFactory: () -> T): T {
		return switch this {
			case Some(value): value;
			case None: defaultFactory();
		}
	}

	/**
		Runs `callback` only if `this` is not null.
	**/
	public extern inline function may(callback: T->Void): Void {
		switch this {
			case Some(value): callback(value);
			case None:
		}
	}

	/**
		Applies `callback` to `this` and returns another `Maybe` value.
	**/
	public extern inline function map<U>(callback: T->U): Option<U> {
		return switch this {
			case Some(value): Some(callback(value));
			case None: None;
		}
	}

	/**
		@return The value if `Some`. Throws error if `None`.
	**/
	public extern inline function unwrap(): T {
		return switch this {
			case Some(value): value;
			case None: throw new Exception("Failed to unwrap");
		}
	}
}
