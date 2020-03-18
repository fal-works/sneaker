package sneaker.macro;

#if macro
import haxe.macro.Expr.Error;
import haxe.macro.Expr.Position;

/**
	Stores code position information.
	This helps to avoid passing position through a chain of function calls.
**/
class PositionStack {
	/**
		The position at which the macro was called.
	**/
	public static final calledPosition = Context.currentPos();

	/**
		Stack of saved position information.
	**/
	static final stack: Array<Position> = [calledPosition];

	/**
		@return Last saved position.
	**/
	public static function peek(): Position
		return stack[stack.length - 1];

	/**
		Saves `position`.
	**/
	public static function push(position: Position): Void
		stack.push(position);

	/**
		Pops last saved position.
	**/
	public static function pop(): Position {
		final position = stack.pop();

		if (stack.length == 0)
			throw new Error("Position stack is empty.", calledPosition);

		return position;
	}

	/**
		Sets `position` to `Context.currentPos()`.
	**/
	public static function reset(): Void {
		stack.resize(1);
		stack[0] = calledPosition;
	}
}
#end
