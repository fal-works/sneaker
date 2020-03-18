package sneaker.trier;

import sneaker.trier.Trier;
import sneaker.types.Result;

@:structInit
class ResultCatcher<T, R> implements Trier<T, R> {
	public final callback: (input: T) -> Result<R, String>;
	public final onFail: OnFailCallback;

	public function new(
		callback: (input: T) -> Result<R, String>,
		onFailType: OnFailType = None
	) {
		this.callback = callback;
		this.onFail = TrierCallbacks.getOnFail(onFailType);
	}

	public function run(
		input: T,
		?tag: Tag,
		?pos: PosInfos
	): TrierResult<R> {
		final result = callback(input);

		switch result {
			case Failed(message):
				onFail(message, tag, pos);
			default:
		}

		return TrierResultBuilder.build(result);
	}
}
