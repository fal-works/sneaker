# sneaker

May or may not help you to debug.

**Requires Haxe 4** (tested with v4.0.5).

## Features

- Assertion
	- Assert any expression that should result to `true` (e.g. `length > 0`)
	- Check against `null`, or unwrap nullable values
- Logging
  - Filter by log levels (Fatal, Error, Warn, Info, Debug, other custom types)
  - Filter by code position (class, method etc.)
  - Filter by "tag"s (name & category bits) attached to any entity/instance
  - Customize formats of log messages (including code position info)
- Testing
	- Categorize test cases (should be OK / should fail / need visual review)
	- Group/manage/run test cases in a naive tree structure
	- Hide results of test cases that successfully passed
	- Print summary of results
- Overall
	- Disable assertion/logging by compiler flags
	- Almost zero runtime cost when disabled
	- Trying to keep platform-independent (howerver HashLink is the main target).

## Downsides

- All of this is nothing but reinventing the wheel!
- Don't know much about other libraries/frameworks
- Developed within a week and not yet very well tested

## Install
<!-- 
```
haxelib install sneaker
```
 -->
## Usage > Assertion

Just import:

```haxe
import sneaker.assertion.Asserter.*;
```

Now you can use `assert()` and `unwrap()` to check values and find bugs.

In your release build these are removed from your code as if they didn't exist.  
See: [Compiler flags](#Compiler-flags)

### `assert()`

Checks any boolean expression.

- If `true`, it has no effect.
- If `false`, recursively checks each sub-expression (same algorithm as [this](https://code.haxe.org/category/macros/assert-with-values.html)) and throws an exception which tells you what was wrong.

```haxe
import sneaker.assertion.Asserter.*;

class Main {
	static function main() {
		final thisIsLess = 100;
		final thisIsGreater = -1;

		trace("Asserting. Should fail...");
		assert(thisIsLess < thisIsGreater); // Throws exception
		trace("Succeeded!?"); // This will not be reached
	}
}
```

```
Main.hx:8: Asserting. Should fail...
Uncaught exception: sneaker.assertion.AssertionException
[ASSERT] Main::main line 9 | - | Assertion failed. (thisIsLess < thisIsGreater) is false.
Breakdown:
  (thisIsLess) => 100
  (thisIsGreater) => -1
  (thisIsLess < thisIsGreater) => false
Called from $Main.main(Main.hx:9)
Called from fun$492(?:1)
```

### `unwrap()`

Checks any nullable expression.

- If not null, it has no effect.
- If null, throws an exception.
- Differences from `assert()`:
    - Does not recursive checks for sub-expressions
    - Returns the value that is checked against null (i.e. `Null<T> -> T`).

```haxe
import sneaker.assertion.Asserter.*;

class Main {
	static function main() {
		// Actually not null
		final nullableA: Null<String> = "Succeeded!\n";

		trace("Unwrapping. Should succeed...");
		final notNullA: String = unwrap(nullableA); // Works fine
		trace(notNullA);

		// Actually not null
		final nullableB: Null<String> = null;

		trace("Unwrapping. Should fail...");
		final notNullB: String = unwrap(nullableB); // Throws exception
		trace(notNullB); // This will not be reached
	}
}
```

```
Main.hx:9: Unwrapping. Should succeed...
Main.hx:11: Succeeded!

Main.hx:16: Unwrapping. Should fail...
Uncaught exception: sneaker.assertion.AssertionException
[ASSERT] Main::main line 17 | - | Unwrap failed. (nullableB) is null.
Called from $Main.main(Main.hx:17)
Called from fun$502(?:1)
```

## Usage > Logging

Just import:

```haxe
import sneaker.log.Logger.*;
```

## Usage > Testing

Just import:

```haxe
import sneaker.unit_test.Tester.*;
```

## Compiler flags

|flag|description|
|---|---|
|`sneaker_log_level`|`100` for FATAL, `200` for ERROR and so on. Defaults to `200`.|
|`sneaker_assertion_disable`|Disables assertion.|
|`sneaker_assertion_print_success`|Prints successful results.|
|`sneaker_assertion_show_compilation`|Prints additional info during the compilation.|
|`sneaker_tagged_disable`|If set, no physical field for `Tagged.tag`.|
|`sneaker_print_disable`|Disables all printing/logging features.|
|`sneaker_print_buffer_disable`|Disables using buffer in `Printer.println()`.|
|`sneaker_print_last_disable`|Disables saving last buffered/printed string.|
|`sneaker_print_generic_disable`|Disables `@:generic` meta in the `Printer` class.|
