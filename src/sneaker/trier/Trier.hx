package sneaker.trier;

/**
	A wrapper of any callback function that takes one argument and may fail under some condition.
	It has some impact on performance, but enables you to preset the behavior on failure
	and safely receive the result value.
**/
interface Trier<T, R> {
	/**
		Runs the preset callback passing `input`.
		@return A `TrierResult` instance, which you can either unwrap or check if the process failed.
	**/
	public function run(
		input: T,
		?tag: Tag,
		?pos: PosInfos
	): TrierResult<R>;

	/**
		Function that is run when `Trier.run()` fails.
	**/
	public final onFail: OnFailCallback;
}
