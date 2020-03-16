package sneaker.log;

/**
	Builder class that enables to create `LogType` instances
	multiple times from the same input values.
**/
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
