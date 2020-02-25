package sneaker.assertion;

using sneaker.format.StringExtension;

@:nullSafety(Strict)
class EvaluationResult {
	public final expressionString:String;
	public final value:Null<Dynamic>;

	public function new(expressionString:String, value:Null<Dynamic>) {
		this.expressionString = expressionString;
		this.value = value;
	}

	public function toString() {
		return '(${expressionString}) => ${value.formatNullable()}';
	}
}
