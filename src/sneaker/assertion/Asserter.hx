package sneaker.assertion;

using haxe.macro.Tools;

import haxe.macro.Expr;
import sneaker.log.LogType;
import sneaker.tag.Tag;

private class Evaluation {
	/** Used as callback in `evaluationArray.map()`. */
	public static final getExecutionExpression = (evaluation: Evaluation) -> evaluation.executionExpression;

	/** String form of the expression to be evaluated. */
	public final expressionString: String;

	/** Expression that assigns the evaluation result to a local variable. */
	public final executionExpression: Expr;

	public function new(expression: Expr, expressionString: String, variableName: String) {
		this.expressionString = expressionString;
		this.executionExpression = macro final $variableName = $expression;
	}
}

/**
 * Collection of assertion functions.
 */
class Asserter {
	/**
	 * Log type used for generating exception message.
	 * Replace or edit this for formatting assertion failure logs.
	 * The filters have no effect.
	 */
	public static var failureLogType = new LogType("[ASSERT]");

	/**
	 * Log type used if the compilation flag `sneaker_assertion_print_success` is set.
	 * Replace or edit this for filtering/formatting assertion success logs.
	 */
	public static var successLogType = new LogType("[ASSERT]");

	/**
	 * Internal function used in `assert()`.
	 */
	static function prepareEvaluations(expressionToAssert: ExprOf<Bool>): Array<Evaluation> {
		final evaluations: Array<Evaluation> = [];

		function preparePart(subExpression: Expr, subExpressionString: String): String {
			final variableName = partialEvaluationResultName(evaluations.length);
			evaluations.push(new Evaluation(subExpression, subExpressionString, variableName));

			return variableName;
		}

		function preparePartRecursive(inputExpression: Expr) {
			return switch (inputExpression.expr) {
				case EConst((CInt(_) | CFloat(_) | CString(_) | CRegexp(_) | CIdent("true" | "false" | "null"))):
					inputExpression;
				case _:
					final expressionString = inputExpression.toString();
					final expression = inputExpression.map(preparePartRecursive); // call for each sub-expressions
					macro $i{preparePart(expression, expressionString)};
			}
		}

		preparePartRecursive(expressionToAssert);

		#if sneaker_assertion_verbose
		final assertedString = expressionToAssert.toString();
		#if sys Sys.println #else trace #end ('[ASSERT] Found: ${assertedString}\t// ${evaluations.length} parts');
		#end

		return evaluations;
	}

	/**
	 * Throws error if `boolExpression` is `false`.
	 *
	 * Compilation flags:
	 * - If `sneaker_assertion_disable` is set, `assert()` has no effect.
	 * - If `sneaker_assertion_verbose` is set, prints additional info during the compilation.
	 * - If `sneaker_assertion_print_success` is set, prints result if successful.
	 *
	 * @param boolExpression Expression that should not be `false`.
	 * @param message Expression that generates message for inserting to the exception.
	 */
	@:noUsing
	public static macro function assert(boolExpression: ExprOf<Bool>, ?tag: ExprOf<Null<Tag>>, ?message: Expr): ExprOf<Void> {
		#if sneaker_assertion_disable
		return macro $b{[]};
		#else
		final evaluations = prepareEvaluations(boolExpression);

		final macroOutputExpressions = evaluations.map(Evaluation.getExecutionExpression);
		final evaluationResults: Array<Expr> = [
			for (i in 0...evaluations.length)
				macro new sneaker.assertion.EvaluationResult($v{evaluations[i].expressionString}, $i{partialEvaluationResultName(i)})
		];

		final pos = boolExpression.pos;
		final lastMacroOutputExpression = macro {
			final __sneakerTag = $tag;
			#if !sneaker_assertion_print_success
			if ($boolExpression != true) {
				final __sneakerAssertionResult = sneaker.assertion.AssertionResult.createError(Assertion, $a{evaluationResults}, __sneakerTag, $message);
				@:pos(boolExpression.pos) throw new sneaker.assertion.AssertionException(__sneakerAssertionResult);
			}
			#else
			final __sneakerEvaluationResults: Array<sneaker.assertion.EvaluationResult> = $a{evaluationResults};
			if ($boolExpression != true) {
				@:pos(pos) final __sneakerAssertionResult = {
					sneaker.assertion.AssertionResult.createError(Assertion, __sneakerEvaluationResults, __sneakerTag, $message);
				}
				@:pos(pos) throw new sneaker.assertion.AssertionException(__sneakerAssertionResult);
			} else {
				@:pos(pos) final __sneakerAssertionResult = sneaker.assertion.AssertionResult.createOk(Assertion, __sneakerEvaluationResults, __sneakerTag);
				__sneakerAssertionResult.printLog(sneaker.assertion.Asserter.successLogType);
			}
			#end
		};

		macroOutputExpressions.push(lastMacroOutputExpression);

		return macro $b{macroOutputExpressions};
		#end
	}

	/**
	 * Throws exception if `object` is `null`.
	 *
	 * Unlike `assert()`, the exception does not contain information about sub-expressions of `object`.
	 *
	 * Compilation flags:
	 * - If `sneaker_assertion_disable` is set,
	 *   `unwrap()` directly returns `object` without checking against null.
	 * - If `sneaker_assertion_print_success` is set, prints result if successful.
	 *
	 * @param object Expression that should not be `null`.
	 * @param message Expression that generates message for inserting to the exception.
	 * @return Evaluation result of `object` that has been checked against null.
	 */
	@:noUsing
	public static macro function unwrap<T>(object: ExprOf<Null<T>>, ?tag: ExprOf<Null<Tag>>, ?message: Expr): ExprOf<T> {
		#if sneaker_assertion_disable
		return macro $object;
		#else
		final expressionString = object.toString();
		final pos = object.pos;

		return macro {
			final __sneakerTag = $tag;
			final __sneakerUnwrappedValue = $object;
			if (__sneakerUnwrappedValue == null) {
				final __sneakerEvaluationResult = new sneaker.assertion.EvaluationResult($v{expressionString}, __sneakerUnwrappedValue);
				@:pos(pos) final __sneakerAssertionResult = {
					sneaker.assertion.AssertionResult.createError(Unwrap, [__sneakerEvaluationResult], __sneakerTag, $message);
				}
				@:pos(pos) throw new sneaker.assertion.AssertionException(__sneakerAssertionResult);
			}
			#if sneaker_assertion_print_success
			else {
				final __sneakerEvaluationResult = new sneaker.assertion.EvaluationResult($v{expressionString}, __sneakerUnwrappedValue);
				@:pos(pos) final __sneakerAssertionResult = sneaker.assertion.AssertionResult.createOk(Unwrap, [__sneakerEvaluationResult], __sneakerTag);
				__sneakerAssertionResult.printLog(sneaker.assertion.Asserter.successLogType);
			}
			#end

			__sneakerUnwrappedValue;
		}
		#end
	}

	static inline function partialEvaluationResultName(index: Int) {
		return '__sneakerPartialEvaluationResult${index}';
	}
}
