package sneaker.assertion;

using sneaker.format.StringExtension;
using sneaker.string_buffer.StringBufExtension;

import haxe.PosInfos;
import haxe.ds.Option;
import sneaker.tag.Tag;
import sneaker.log.LogType;

/**
 * Result of assertion, including evaluation results of sub-expressions.
 */
class AssertionResult {
	public static function createError(
		type: AssertionType,
		evaluationResults: Array<EvaluationResult>,
		?tag: Tag,
		?message: String,
		?pos: PosInfos
	) {
		return new AssertionResult(
			type,
			evaluationResults,
			Some(message.toOptionalString()),
			tag,
			pos
		);
	}

	public static function createOk(
		type: AssertionType,
		evaluationResults: Array<EvaluationResult>,
		?tag: Tag,
		?pos: PosInfos
	) {
		return new AssertionResult(type, evaluationResults, None, tag, pos);
	}

	/** Type of assertion, either `Assertion` or `Unwrap`. */
	public final assertionType: AssertionType;

	/**
	 * Evaluation list of sub-expressions of which the asserted expression consists.
	 * The last element is the evaluation of the asserted expression itself.
	 */
	public final evaluationResults: Array<EvaluationResult>;

	/** Alias for the last element of `evaluationResults`. */
	public var wholeEvaluationResult(get, never): EvaluationResult;

	/**
	 * - If succeeded: `None`.
	 * - If failed: `Some(message:Option<String>)`.
	 */
	public final error: Option<Option<String>>;

	/** Text that includes the content of `this`, excluding the tag and position informaion. */
	public final contentString: String;

	/** A `Tag` related with this assertion. */
	public final tag: Null<Tag>;

	/** Code position where this assertion was done. */
	public final positionInformations: Null<PosInfos>;

	inline function get_wholeEvaluationResult() {
		return evaluationResults[evaluationResults.length - 1];
	}

	public function new(
		assertionType: AssertionType,
		evaluationResults: Array<EvaluationResult>,
		error: Option<Option<String>>,
		?tag: Tag,
		?pos: PosInfos
	) {
		this.assertionType = assertionType;
		this.evaluationResults = evaluationResults;
		this.error = error;

		this.contentString = generateContentString();

		this.tag = tag;
		this.positionInformations = pos;
	}

	/**
	 * @return Log text created from data of `this` using `logType`.
	 */
	public function createLogString(logType: LogType): String {
		return logType.createLogString(
			contentString,
			tag,
			positionInformations
		);
	}

	/**
	 * Prints log text created from data of `this` using `logType`.
	 */
	public function printLog(logType: LogType) {
		logType.print(contentString, tag, positionInformations);
	}

	function addSummary(buffer: StringBuf): StringBuf {
		switch (error) {
			case None:
				buffer.add('${assertionType} succeeded.');
				final result = wholeEvaluationResult;
				buffer.add(' (${result.expressionString})');
			case Some(message):
				buffer.add('${assertionType} failed.');
				final result = wholeEvaluationResult;
				@:nullSafety(Off)
				buffer.add(' (${result.expressionString}) is ${result.value}.');
				switch (message) {
					case Some(messageValue): buffer.lfAdd('Message: ${messageValue}');
					default:
				}
		}

		return buffer;
	}

	function addDetails(buffer: StringBuf): StringBuf {
		if (evaluationResults.length > 1) {
			buffer.lfAdd('Breakdown:');
			buffer.lfIndentAddLines(evaluationResults);
		}

		return buffer;
	}

	function generateContentString(): String {
		final buffer = new StringBuf();

		addSummary(buffer);
		addDetails(buffer);

		return buffer.toString();
	}
}
