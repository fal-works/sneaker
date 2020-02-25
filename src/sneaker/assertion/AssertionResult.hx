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
	public static function createError(evaluationList:Array<EvaluationResult>, ?message:String, ?pos:PosInfos) {
		return new AssertionResult(evaluationList, Some(message.toOptionalString()), pos);
	}

	/**
	 * Evaluation list of sub-expressions of which the asserted expression consists.
	 * The last element is the evaluation of the asserted expression itself.
	 */
	public final evaluationList:Array<EvaluationResult>;

	/**
	 * Alias for the last element of `evaluationList`.
	 */
	public var wholeEvaluation(get, never):EvaluationResult;

	public final error:Option<Option<String>>;
	public final positionInformations:Null<PosInfos>;

	var contentString:String;

	inline function get_wholeEvaluation() {
		return evaluationList[evaluationList.length - 1];
	}

	public function new(evaluationList:Array<EvaluationResult>, error:Option<Option<String>>, ?pos:PosInfos) {
		this.evaluationList = evaluationList;
		this.error = error;
		this.positionInformations = pos;
		this.contentString = generateContentString();
	}

	public function toString():String {
		return contentString;
	}

	function addHead(buffer:StringBuf):StringBuf {
		buffer.add('Assertion failed. (${wholeEvaluation.expressionString}) is ${cast wholeEvaluation.result}.');

		return buffer;
	}

	function addMessage(buffer:StringBuf):StringBuf {
		switch (error) {
			case None:
			case Some(message):
				switch(message) {
					case Some(messageValue):
						buffer.lfAdd('Message: ${messageValue}');
					default:
				}

			default:
		}

		return buffer;
	}

	function addPosition(buffer:StringBuf):StringBuf {
		if (positionInformations != null)
			buffer.lfAdd('Position: ${positionInformations.formatClassMethodLine()}');

		return buffer;
	}

	function addDetails(buffer:StringBuf):StringBuf {
		if (evaluationList.length > 1) {
			buffer.lfAdd('Details:');
			buffer.lfIndentAddLines(evaluationList);
		}

		return buffer;
	}

	function generateContentString():String {
		final buffer = new StringBuf();

		addHead(buffer);
		addMessage(buffer);
		addPosition(buffer);
		addDetails(buffer);

		return buffer.toString();
	}
}
