package sneaker.exception;

import sneaker.format.CallStackItemExtension;

class ExceptionSettings {
	/**
		Default value for `appendCallStack` of each instance.
	**/
	public static var appendCallStackDefault = false;

	/**
		Formatting function used when casting an exception to `String`.
		Can be replaced with any custom function.
	**/
	public static var callStackFormat = CallStackItemExtension.formatStackIndent.bind(_);
}
