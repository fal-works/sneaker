package sneaker.assertion;

/**
 * A pair of an expression string and its evaluated value.
 */
@:nullSafety(Strict)
class EvaluationResult {
	public final expressionString:String;
	public final value:Null<Any>;

	public function new(expressionString:String, value:Null<Any>) {
		this.expressionString = expressionString;
		this.value = value;
	}

	public function toString() {
		return @:nullSafety(Off) '(${expressionString}) => ${value}';
	}
}
