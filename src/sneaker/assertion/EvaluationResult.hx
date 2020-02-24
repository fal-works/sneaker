package sneaker.assertion;

using sneaker.format.StringExtension;

@:nullSafety(Strict)
class EvaluationResult {
	public final expressionString:String;
	public final result:Null<Dynamic>;

	public function new(expressionString:String, result:Null<Dynamic>) {
		this.expressionString = expressionString;
		this.result = result;
	}

	public function toString() {
		return '(${expressionString}) => ${result.formatNullable()}';
	}
}
