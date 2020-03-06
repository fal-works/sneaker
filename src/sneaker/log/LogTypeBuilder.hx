package sneaker.log;

@:structInit
class LogTypeBuilder {
	final prefix: String;
	final level: Int;

	public function new(prefix: String, level: Int) {
		this.prefix = prefix;
		this.level = level;
	}

	public function build(): LogType {
		return new LogType(prefix, level);
	}
}
