package sneaker.assertion;

import sneaker.log.LogType;

class AsserterSettings {
	/**
	 * Log type used for generating exception message.
	 * Replace or edit this for formatting assertion failure logs.
	 * The filters have no effect.
	 */
	public static var failureLogType = new LogType("[ASSERT]");

	/**
	 * Log type used if the compilation flag `sneaker_assertion_print_success` is set.
	 * Replace or edit this for filtering/formatting assertion success logs.
	 */
	public static var successLogType = new LogType("[ASSERT]");
}
