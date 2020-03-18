package sneaker.trier;

import sneaker.trier.Trier;
import sneaker.types.Result;
import haxe.macro.Context;

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
		var message = "";
		var failed = false;
		switch result {
			case Failed(s):
				failed = true;
				message = s;
			default:
		}

		if (failed) {
			onFail(message, tag, pos);
		}

		return TrierResultBuilder.build(result);
	}
}
