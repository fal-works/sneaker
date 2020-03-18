package sneaker.trier;

import sneaker.trier.Trier;

@:structInit
class NullCatcher<T, R> implements Trier<T, R> {
	public final callback: (input: T) -> Null<R>;
	public final onFail: OnFailCallback;
	final failMessage: String;

	public function new(callback: (input: T) -> Null<R>, failMessage: String, onFailType: OnFailType = None) {
		this.callback = callback;
		this.failMessage = failMessage;
		this.onFail = TrierCallbacks.getOnFail(onFailType);
	}

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
