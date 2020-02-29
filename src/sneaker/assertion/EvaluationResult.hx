package sneaker.assertion;

/**
 * A pair of an expression string and its evaluated value.
 */
class EvaluationResult {
	public static final stringify = (result: EvaluationResult) -> result.toString();

	public final expressionString: String;
	public final value: Null<Dynamic>;

	public function new(expressionString: String, value: Null<Dynamic>) {
		this.expressionString = expressionString;
		this.value = value;
	}

	public function toString(): String {
		return @:nullSafety(Off) '(${expressionString}) => ${value}';
	}
}
