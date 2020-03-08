package sneaker.log;

using StringTools;

// @formatter:off

@:nullSafety
class LogFormats {
	/** Separator charactor used in standard log formats. Defaults to the vertical bar `|`. **/
	public static var separator = "|";

	/** Position to start the log text body. Used for right-padding after the prefix. **/
	public static var alignmentPosition = 8;

	// full use of all arguments

	/**
		The default, normal format.

		Example: "[ERROR]  my_module.MyClass::myMethod line 1 | myTag | myMessage"
	 **/
	public static final prefixPositionTagMessage: LogFormat = (logType, message, tag, ?pos) ->
		'${prefix(logType)} ${logType.positionFormat(pos)} ${separator} ${tag} ${separator} ${message}';

	public static final prefixPositionTagLineFeedMessage: LogFormat = (logType, message, tag, ?pos) ->
		'${prefix(logType)} ${logType.positionFormat(pos)} ${separator} ${tag}\n${message}';

	public static final prefixPositionLineFeedTagMessage: LogFormat = (logType, message, tag, ?pos) ->
		'${prefix(logType)} ${logType.positionFormat(pos)}\n${tag} ${separator} ${message}';

	public static final lineFeedForEach: LogFormat = (logType, message, tag, ?pos) ->
		'${prefix(logType)}\nPosition: ${logType.positionFormat(pos)}\nTag name: ${tag}\nMessage : ${message}';

	// partial use of arguments

	/** Example: "[ERROR]  myMessage" **/
	public static final prefixMessage: LogFormat = (logType, message, tag, ?pos) ->
		'${prefix(logType)} ${message}';

	/** Example: "myMessage" **/
	public static final messageOnly: LogFormat = (logType, message, tag, ?pos) ->
		'${message}';

	// aliases
	public static final aliases = {
		normal: prefixPositionTagMessage,
		simple: prefixMessage
	};

	static final space = " ";

	static inline function prefix(logType: LogType): String
		return logType.prefix.rpad(space, alignmentPosition);
}
