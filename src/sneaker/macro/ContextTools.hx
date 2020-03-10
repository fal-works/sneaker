package sneaker.macro;

#if macro
class ContextTools {
	/**
		@return Current file path, e.g. "src/Main.hx".
	**/
	public static inline function getFilePath(): String {
		final position = Context.getPosInfos(Context.currentPos());
		return '${position.file}';
	}
}
#end
