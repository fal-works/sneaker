package sneaker.log;

@:nullSafety
class LogFormats {
	/** Separator charactor used in standard log formats. Defaults to the vertical bar `|`. */
	public static var separator = "|";

	// full use of all arguments

	/**
	 * The default, normal format.
	 *
	 * Example: "[ERROR]  my_module.MyClass::myMethod line 1 | myTag | myMessage"
	 */
	public static final prefixPositionTagMessage: LogFormat = (logType, message, tag, ?pos) ->
		'${logType.prefix} ${logType.positionFormat(pos)} ${separator} ${tag} ${separator} ${message}';

	public static final prefixPositionTagLineFeedMessage: LogFormat = (logType, message, tag, ?pos) ->
		'${logType.prefix} ${logType.positionFormat(pos)} ${separator} ${tag}\n${message}';

	public static final prefixPositionLineFeedTagMessage: LogFormat = (logType, message, tag, ?pos) ->
		'${logType.prefix} ${logType.positionFormat(pos)}\n${tag} ${separator} ${message}';

	public static final lineFeedForEach: LogFormat = (logType, message, tag, ?pos) ->
		'${logType.prefix}\nPosition: ${logType.positionFormat(pos)}\nTag name: ${tag}\nMessage : ${message}';

	// partial use of arguments

	/** Example: "[ERROR]  myMessage" */
	public static final prefixMessage: LogFormat = (logType, message, tag, ?pos) ->
		'${logType.prefix} ${message}';

	/** Example: "myMessage" */
	public static final messageOnly: LogFormat = (logType, message, tag, ?pos) ->
		'${message}';

	// aliases
	public static final aliases = {
		normal: prefixPositionTagMessage,
		simple: prefixMessage
	};
}
