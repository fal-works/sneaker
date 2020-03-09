package sneaker.assertion;

/**
	A pair of an expression string and its evaluated value.
**/
class EvaluationResult {
	/** Function used as callback for executing `toString()`. **/
	public static final stringify = (result: EvaluationResult) -> result.toString();

	/** Instance used if the asserted expression is a simple `true` literal. **/
	public static final trueLiteral = new EvaluationResult("true", true);

	/** Instance used if the asserted expression is a simple `false` literal. **/
	public static final falseLiteral = new EvaluationResult("false", false);

	/** String representation of an expression. **/
	public final expressionString: String;

	/** Evaluated value of the expression. **/
	public final value: Null<Dynamic>;

	public function new(expressionString: String, value: Null<Dynamic>) {
		this.expressionString = expressionString;
		this.value = value;
	}

	public function toString(): String {
		return @:nullSafety(Off) '(${expressionString}) => ${value}';
	}
}
