package sneaker.trier;

import sneaker.types.Result;

/**
	Result returned from any class that implements `Trier` interface.
**/
#if eval
typedef TrierResult<R> = {
	/**
		The returned value from the process in `Result` representation.
	**/
	public final result: Result<R, String>;

	/**
		`true` if the process has failed.
	**/
	public final failed: Bool;

	/**
		@return The actual value. Throws error if failed.
	**/
	public function unwrap(?tag: Tag, ?pos: PosInfos): R;

	/**
		@return The failure message. Throws error if the process did not fail.
	**/
	public function unwrapFailure(?tag: Tag, ?pos: PosInfos): String;
}
#else
class TrierResult<R> {
	/**
		The returned value from the process in `Result` representation.
	**/
	public final result: Result<R, String>;

	/**
		`true` if the process has failed.
	**/
	public final failed: Bool;

	/**
		`true` if the process has failed.
	**/
	public function new(result: Result<R, String>, failed: Bool) {
		this.result = result;
		this.failed = failed;
	}

	/**
		@return The actual value. Throws error if failed.
	**/
	public inline function unwrap(?tag: Tag, ?pos: PosInfos): R
		return TrierResultTools.unwrap(this.result, tag, pos);

	/**
		@return The failure message. Throws error if the process did not fail.
	**/
	public inline function unwrapFailure(?tag: Tag, ?pos: PosInfos): String
		return TrierResultTools.unwrapFailure(this.result, tag, pos);
}
#end
