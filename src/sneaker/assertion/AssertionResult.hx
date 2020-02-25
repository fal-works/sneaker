package sneaker.assertion;

using sneaker.format.StringExtension;
using sneaker.format.StringBufExtension;
using sneaker.format.PosInfosExtension;

import haxe.PosInfos;
import haxe.ds.Option;

/**
 * Result of assertion, including evaluation results of sub-expressions.
 */
@:nullSafety(Strict)
class AssertionResult {
	public static function createError(evaluationResults:Array<EvaluationResult>, ?message:String, ?pos:PosInfos) {
		return new AssertionResult(evaluationResults, Some(message.toOptionalString()), pos);
	}

	public static function createOk(evaluationResults:Array<EvaluationResult>, ?pos:PosInfos) {
		return new AssertionResult(evaluationResults, None, pos);
	}

	/**
	 * Evaluation list of sub-expressions of which the asserted expression consists.
	 * The last element is the evaluation of the asserted expression itself.
	 */
	public final evaluationResults:Array<EvaluationResult>;

	/**
	 * Alias for the last element of `evaluationResults`.
	 */
	public var wholeEvaluationResult(get, never):EvaluationResult;

	public final error:Option<Option<String>>;
	public final positionInformations:Null<PosInfos>;

	var contentString:String;

	inline function get_wholeEvaluationResult() {
		return evaluationResults[evaluationResults.length - 1];
	}

	public function new(evaluationResults:Array<EvaluationResult>, error:Option<Option<String>>, ?pos:PosInfos) {
		this.evaluationResults = evaluationResults;
		this.error = error;
		this.positionInformations = pos;
		this.contentString = generateContentString();
	}

	public function toString():String {
		return contentString;
	}

	function addHead(buffer:StringBuf):StringBuf {
		switch (error) {
			case None:
				buffer.add('Assertion succeeded.');
				buffer.add(' (${wholeEvaluationResult.expressionString}) is ${cast wholeEvaluationResult.value}.');
			case Some(message):
				buffer.add('Assertion failed.');
				buffer.add(' (${wholeEvaluationResult.expressionString}) is ${cast wholeEvaluationResult.value}.');
				switch (message) {
					case Some(messageValue):
						buffer.lfAdd('Message: ${messageValue}');
					default:
				}
		}

		return buffer;
	}

	function addPosition(buffer:StringBuf):StringBuf {
		if (positionInformations != null)
			buffer.lfAdd('Position: ${positionInformations.formatClassMethodLine()}');

		return buffer;
	}

	function addDetails(buffer:StringBuf):StringBuf {
		if (evaluationResults.length > 1) {
			buffer.lfAdd('Details:');
			buffer.lfIndentAddLines(evaluationResults);
		}

		return buffer;
	}

	function generateContentString():String {
		final buffer = new StringBuf();

		addHead(buffer);
		addPosition(buffer);
		addDetails(buffer);

		return buffer.toString();
	}
}
