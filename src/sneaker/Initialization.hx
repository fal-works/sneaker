package sneaker;

#if macro
class Initialization {
	/**
		Entry point of the initialization macro.
	**/
	static function run() {
		sneaker.log.Constants.ensureLogLevelDefine();
		CompilerFlags.initialize();
	}
}
#end
