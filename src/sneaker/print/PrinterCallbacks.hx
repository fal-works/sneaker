package sneaker.print;

class PrinterCallbacks {
	/** @see `Printer.println()` */
	public static final println = (s: String) -> Printer.println(s);

	/** @see `Printer.print()` */
	public static final print = (s: String) -> Printer.print(s);

	/** @see `Printer.printlnDirect()` */
	public static final printlnDirect = (s: String) -> Printer.printlnDirect(s);

	/** @see `Printer.printDirect()` */
	public static final printDirect = (s: String) -> Printer.printDirect(s);

	/** @see `Printer.printlnForced()` */
	public static final printlnForced = (s: String) -> Printer.printlnForced(s);

	/** @see `Printer.printForced()` */
	public static final printForced = (s: String) -> Printer.printForced(s);

	/** @see `Printer.printlnReturn()` */
	public static final printlnReturn = (s: String) -> Printer.printlnReturn(s);

	/** @see `Printer.printlnThrow()` */
	public static final printlnThrow = (s: String) -> Printer.printlnThrow(s);
}
