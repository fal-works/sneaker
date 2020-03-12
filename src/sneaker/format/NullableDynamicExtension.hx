package sneaker.format;

import haxe.ds.Option;

class NullableDynamicExtension {
	/**
		@return `Int` representation.
	**/
	public static inline function dynamicToInt(
		value: Null<Dynamic>,
		defaultValue: Int
	): Int {
		return if (value == null) defaultValue else {
			final parsed = Std.parseInt(Std.string(value));
			if (parsed == null) defaultValue else parsed;
		}
	}

	/**
		@return `Option<Int>` representation.
	**/
	public static inline function dynamicToOptionalInt(value: Null<Dynamic>): Option<Int> {
		return if (value == null) None else {
			final parsed = Std.parseInt(Std.string(value));
			if (parsed == null) None else Some(parsed);
		}
	}
}
