package sneaker.trier;

/**
	A wrapper of any callback function that takes one argument and may throw exceptions.
	Automatically catches and runs `onFail()` when you call `run()` and any exception is thrown.
**/
@:structInit
class ThrowCatcher<T, R> implements Trier<T, R> {
	/** @inheritdoc **/
	public final onFail: OnFailCallback;

	public final callback: (input: T) -> R;

	public function new(callback: (input: T) -> R, onFailType: OnFailType = None) {
		this.callback = callback;
		this.onFail = TrierCallbacks.getOnFail(onFailType);
	}

	/** @inheritdoc **/
	public function run(
		input: T,
		?tag: Tag,
		?pos: PosInfos
	): TrierResult<R> {
		try {
			final returned = callback(input);
			return TrierResultTools.build(Ok(returned), false);
		} catch (error:Dynamic) {
			final message = Std.string(error);
			onFail(message, tag, pos);
			return TrierResultTools.build(Failed(message), true);
		}
	}
}
