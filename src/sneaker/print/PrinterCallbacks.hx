package sneaker.print;

class PrinterCallbacks {
	/** @see `Printer.println()` **/
	public static final println = (s: String) -> {
		#if !sneaker_print_disable
		Printer.println(s);
		#end
	}

	/** @see `Printer.print()` **/
	public static final print = (s: String) -> {
		#if !sneaker_print_disable
		Printer.print(s);
		#end
	}

	/** @see `Printer.printlnDirect()` **/
	public static final printlnDirect = (s: String) -> {
		#if !sneaker_print_disable
		Printer.printlnDirect(s);
		#end
	}

	/** @see `Printer.printDirect()` **/
	public static final printDirect = (s: String) -> {
		#if !sneaker_print_disable
		Printer.printDirect(s);
		#end
	}

	/** @see `Printer.printlnForced()` **/
	public static final printlnForced = (s: String) -> {
		#if !sneaker_print_disable
		Printer.printlnForced(s);
		#end
	}

	/** @see `Printer.printForced()` **/
	public static final printForced = (s: String) -> {
		#if !sneaker_print_disable
		Printer.printForced(s);
		#end
	}

	/** @see `Printer.printlnReturn()` **/
	public static final printlnReturn = (s: String) -> {
		Printer.printlnReturn(s);
		return s;
	}

	/** @see `Printer.printlnThrow()` **/
	public static final printlnThrow = (s: String) -> Printer.printlnThrow(s);
}
