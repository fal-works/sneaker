package sneaker;

#if macro
class Initialization {
	static function run() {
		sneaker.log.Constants.ensureLogLevelDefine();
		sneaker.macro.Initialization.ensureLogLevelDefine();
		sneaker.macro.Initialization.ensureMessageLevelDefine();
	}
}
#end
