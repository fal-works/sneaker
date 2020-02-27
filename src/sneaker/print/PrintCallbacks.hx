package sneaker.print;

class PrintCallbacks {
	/** @see `Print.println()` */
	public static final println = (s: String) -> Print.println(s);

	/** @see `Print.print()` */
	public static final print = (s: String) -> Print.print(s);

	/** @see `Print.printlnDirect()` */
	public static final printlnDirect = (s: String) -> Print.printlnDirect(s);

	/** @see `Print.printDirect()` */
	public static final printDirect = (s: String) -> Print.printDirect(s);

	/** @see `Print.printlnForced()` */
	public static final printlnForced = (s: String) -> Print.printlnForced(s);

	/** @see `Print.printForced()` */
	public static final printForced = (s: String) -> Print.printForced(s);

	/** @see `Print.printlnReturn()` */
	public static final printlnReturn = (s: String) -> Print.printlnReturn(s);

	/** @see `Print.printlnThrow()` */
	public static final printlnThrow = (s: String) -> Print.printlnThrow(s);
}
