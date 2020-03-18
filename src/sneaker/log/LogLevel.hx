package sneaker.log;

/**
	Built-in log levels.
**/
enum abstract LogLevel(Int) to Int {
	final Fatal = 100;
	final Error = 200;
	final Warn = 300;
	final Info = 400;
	final Debug = 500;
}
