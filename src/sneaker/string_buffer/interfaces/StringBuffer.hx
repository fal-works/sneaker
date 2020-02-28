package sneaker.string_buffer.interfaces;

interface StringBuffer {
	var length(get, never): Int;
	function add<T>(x: T): Void;
	function addChar(c: Int): Void;
	function addSub(
		s: String,
		pos: Int,
		?len: Int
	): Void;
	function toString(): String;
}
