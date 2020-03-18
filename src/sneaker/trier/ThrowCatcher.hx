package sneaker.trier;

import sneaker.trier.Trier;

@:structInit
class ThrowCatcher<T, R> implements Trier<T, R> {
	public final callback: (input: T) -> R;
	public final onFail: OnFailCallback;

	public function new(callback: (input: T) -> R, onFailType: OnFailType = None) {
		this.callback = callback;
		this.onFail = TrierCallbacks.getOnFail(onFailType);
	}

	public function run(
		input: T,
		?tag: Tag,
		?pos: PosInfos
	): TrierResult<R> {
		try {
			final returned = callback(input);
			return TrierResultBuilder.build(Ok(returned));
		} catch (error:Dynamic) {
			final message = Std.string(error);
			onFail(message, tag, pos);
			return TrierResultBuilder.build(Failed(message));
		}
	}
}
