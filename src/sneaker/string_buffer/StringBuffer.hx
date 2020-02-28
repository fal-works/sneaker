package sneaker.string_buffer;

/**
 * Extended from `std.StringBuf`,
 * declared as an implementation of `StringBuffer` interface.
 *
 * This enables you to use `StringBufferExtension` functions.
 */
@:using(sneaker.string_buffer.StringBufferExtension)
class StringBuffer extends StringBuf implements sneaker.string_buffer.interfaces.StringBuffer {
	public function new() {
		super();
	}
}
