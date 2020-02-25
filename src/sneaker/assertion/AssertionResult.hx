package sneaker.assertion;

using sneaker.format.StringExtension;
using sneaker.format.StringBufExtension;

import haxe.PosInfos;
import haxe.ds.Option;
import sneaker.tag.Tag;

/**
 * Result of assertion, including evaluation results of sub-expressions.
 */
@:nullSafety(Strict)
class AssertionResult {
	public static function createError(type:AssertionType, evaluationResults:Array<EvaluationResult>, ?tag:Tag, ?message:String, ?pos:PosInfos) {
		return new AssertionResult(type, evaluationResults, tag, Some(message.toOptionalString()), pos);
	}

	public static function createOk(type:AssertionType, evaluationResults:Array<EvaluationResult>, ?tag:Tag, ?pos:PosInfos) {
		return new AssertionResult(type, evaluationResults, tag, None, pos);
	}

	/** Type of assertion, either `Assertion` or `Unwrap`. */
	public final assertionType:AssertionType;

	/**
	 * Evaluation list of sub-expressions of which the asserted expression consists.
	 * The last element is the evaluation of the asserted expression itself.
	 */
	public final evaluationResults:Array<EvaluationResult>;

	/** Alias for the last element of `evaluationResults`. */
	public var wholeEvaluationResult(get, never):EvaluationResult;

	/** A `Tag` related with this assertion. */
	public final tag:Null<Tag>;

	/**
	 * - If succeeded: `None`.
	 * - If failed: `Some(message:Option<String>)`.
	 */
	public final error:Option<Option<String>>;

	/** Code position where this assertion was done. */
	public final positionInformations:Null<PosInfos>;

	var contentString:String;

	inline function get_wholeEvaluationResult() {
		return evaluationResults[evaluationResults.length - 1];
	}

	public function new(assertionType:AssertionType, evaluationResults:Array<EvaluationResult>, ?tag:Tag, error:Option<Option<String>>, ?pos:PosInfos) {
		this.assertionType = assertionType;
		this.evaluationResults = evaluationResults;
		this.tag = tag;
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
