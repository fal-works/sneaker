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
	public static function createError(type:AssertionType, evaluationResults:Array<EvaluationResult>, ?message:String, ?pos:PosInfos) {
		return new AssertionResult(type, evaluationResults, Some(message.toOptionalString()), pos);
	}

	public static function createOk(type:AssertionType, evaluationResults:Array<EvaluationResult>, ?pos:PosInfos) {
		return new AssertionResult(type, evaluationResults, None, pos);
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

	public final assertionType:AssertionType;
	public final error:Option<Option<String>>;
	public final positionInformations:Null<PosInfos>;

	var contentString:String;

	inline function get_wholeEvaluationResult() {
		return evaluationResults[evaluationResults.length - 1];
	}

	public function new(assertionType:AssertionType, evaluationResults:Array<EvaluationResult>, error:Option<Option<String>>, ?pos:PosInfos) {
		this.assertionType = assertionType;
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
				buffer.add('${assertionType} succeeded.');
				final result = wholeEvaluationResult;
				buffer.add(' (${result.expressionString})');
			case Some(message):
				buffer.add('${assertionType} failed.');
				final result = wholeEvaluationResult;
				buffer.add(' (${result.expressionString}) is ${cast result.value}.');
				switch (message) {
					case Some(messageValue):
						buffer.lfAdd('Message: ${messageValue}');
					default:
				}
				if (positionInformations != null)
					buffer.lfAdd('Position: ${positionInformations.formatClassMethodLine()}');
		}

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
		addDetails(buffer);

		return buffer.toString();
	}
}
