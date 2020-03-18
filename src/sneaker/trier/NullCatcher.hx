package sneaker.trier;

/**
	A wrapper of any callback function that takes one argument and may return `null`.
	Automatically runs `onFail()` when you call `run()` and the result is `null`.
**/
@:structInit
class NullCatcher<T, R> implements Trier<T, R> {
	/** @inheritdoc **/
	public final onFail: OnFailCallback;

	public final callback: (input: T) -> Null<R>;
	public final failMessage: String;

	public function new(callback: (input: T) -> Null<R>, failMessage: String, onFailType: OnFailType = None) {
		this.callback = callback;
		this.failMessage = failMessage;
		this.onFail = TrierCallbacks.getOnFail(onFailType);
	}

	/** @inheritdoc **/
	public function run(
		input: T,
		?tag: Tag,
		?pos: PosInfos
	): TrierResult<R> {
		final message = failMessage;
		final result = callback(input);

		if (result == null) {
			onFail(message, tag, pos);
			return TrierResultTools.build(Failed(message), true);
		}

		return TrierResultTools.build(Ok(result), false);
	}
}
