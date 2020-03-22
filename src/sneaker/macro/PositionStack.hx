package sneaker.macro;

#if macro
import haxe.macro.Expr.Position;

/**
	Stores code position information.
	This helps to avoid passing position through a chain of function calls.
**/
class PositionStack {
	/**
		Stack of saved position information.
	**/
	static final stack: Array<Position> = [];

	/**
		Refleshes the stack with `Context.currentPos()`.
	**/
	public static function reset(): Void {
		stack.resize(1);
		stack[0] = Context.currentPos();
	}

	/**
		@return Last saved position, or `Context.currentPos()` if empty.
	**/
	public static function peek(): Position {
		if (stack.length == 0) reset();

		return stack[stack.length - 1];
	}

	/**
		Saves `position`.
	**/
	public static function push(position: Position): Void
		stack.push(position);

	/**
		Pops last saved position, or `Context.currentPos()` if empty.
	**/
	public static function pop(): Position {
		if (stack.length == 0) reset();

		return stack.pop();
	}
}
#end
