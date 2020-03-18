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
