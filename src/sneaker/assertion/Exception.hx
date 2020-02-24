package sneaker.assertion;

using sneaker.format.StringBufAddExtension;
using sneaker.format.PosInfosExtension;

import haxe.PosInfos;
import haxe.CallStack;
import haxe.ds.Option;

/**
 * Exception raised by assertion failures.
 */
@:nullSafety(Strict)
class Exception extends sneaker.exception.Exception {
	/**
	 * Evaluation list of sub-expressions of which the asserted expression consists.
	 * The last element is the evaluation of the asserted expression itself.
	 */
	public final evaluationList:Array<EvaluationResult>;

	public final message:Option<Dynamic>;
	public final posInfos:Option<PosInfos>;

	/**
	 * Alias for the last element of `evaluationList`.
	 */
	public var wholeEvaluation(get, never):EvaluationResult;

	inline function get_wholeEvaluation() {
		return evaluationList[evaluationList.length - 1];
	}

	public function new(evaluationList:Array<EvaluationResult>, ?message:Dynamic, ?pos:PosInfos) {
		this.evaluationList = evaluationList;
		this.message = if (message != null) Some(message) else None;
		this.posInfos = if (pos != null) Some(pos) else None;

		final currentCallStack = CallStack.callStack();
		currentCallStack.shift();
		super(generateContentString(), currentCallStack);
	}

	function addHead(buffer:StringBuf):StringBuf {
		buffer.add('Assertion failed. (${wholeEvaluation.expressionString}) is ${cast wholeEvaluation.result}.');

		return buffer;
	}

	function addMessage(buffer:StringBuf):StringBuf {
		switch (message) {
			case Some(messageValue):
				buffer.lfAdd('Message: ${messageValue}');
			default:
		}

		return buffer;
	}

	function addPosition(buffer:StringBuf):StringBuf {
		switch (posInfos) {
			case Some(posInfosValue):
				buffer.lfAdd('Position: ${posInfosValue.formatClassMethodLine()}');
			default:
		}

		return buffer;
	}

	function addDetails(buffer:StringBuf):StringBuf {
		if (evaluationList.length > 1) {
			buffer.lfAdd('Details:');

			for (part in evaluationList)
				buffer.lfIndentAdd(part.toString());
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
