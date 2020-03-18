package sneaker.trier;

import sneaker.types.Result;

/**
	A wrapper of any callback function that takes one argument and returns any `Result` instance.
	Automatically runs `onFail()` when you call `run()` and the result is `Failed`.
**/
@:structInit
class ResultCatcher<T, R> implements Trier<T, R> {
	/** @inheritdoc **/
	public final onFail: OnFailCallback;

	public final callback: (input: T) -> Result<R, String>;

	public function new(
		callback: (input: T) -> Result<R, String>,
		onFailType: OnFailType = None
	) {
		this.callback = callback;
		this.onFail = TrierCallbacks.getOnFail(onFailType);
	}

	/** @inheritdoc **/
	public function run(
		input: T,
		?tag: Tag,
		?pos: PosInfos
	): TrierResult<R> {
		final result = callback(input);

		final failed = switch result {
			case Failed(message):
				onFail(message, tag, pos);
				true;
			default:
				false;
		}

		return TrierResultTools.build(result, failed);
	}
}
