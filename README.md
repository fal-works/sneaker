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
	- Basically platform-independent (howerver HashLink is the main target)

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

### Runtime settings

```haxe
import sneaker.assertion.AsserterSettings;
```

And assign your custom values following the comments.


## Usage > Logging

Just import:

```haxe
import sneaker.log.Logger.*;
```

### Basics

```haxe
import sneaker.log.Logger.*;

class Main {
	static function main() {
		debug("This is a debug message."); // level: 500
		info("This is an info message!"); // level: 400
		warn("This is a warning message!"); // level: 300
		error("This is an error message!"); // level: 200
		fatal("This is a fatal message! It's all over!"); // level: 100
	}
}
```

If `-D sneaker_log_level=200` (default), only the logs on the level 200 or lower are printed.

```
[ERROR]  Main::main line 8 | - | This is an error message!
[FATAL]  Main::main line 9 | - | This is a fatal message! It's all over!
```

### Using "Tag"s

A `Tag` instance is something that is attached to identify any instance or entity.

A quick way is to extend the `Tagged` class and create your own objects.

```haxe
class GameObject extends sneaker.tag.Tagged {
	public function new() {
		super();
	}
}

class Main {
	static function main() {
		final object = new GameObject();
		object.newTag("player character"); // Attach a new Tag with a name

		object.error("Oh it's broken"); // This prints an ERROR log
		// This is the same as:
		// sneaker.log.Logger.error("Oh it's broken", object.tag);
	}
}
```

```
[ERROR]  Main::main line 12 | player character | Oh it's broken
```

In addition to its `name`, a `Tag` also has `bits`.  
This is a bit array (actually `Int`) which specifies to which category the tag belongs.

Both `name` and `bits` can be used for filtering log messages.

### Customization

Each `Logger` function has an underlying `LogType` instance (see `sneaker.log.LogTypes`),
which can be edited or even replaced with new ones.

Each `LogType` instance has following contents (which can be changed individually):
- `prefix`: String value for appending to log texts
- `tagFilter`: Filtering predicate for `Tag`s
- `positionFilter`: Filtering predicate for code position information (class, method, ...)
- `positionFormat`: Formatter function for position information
- `logFormat`: Formatter function for the entire log text


## Usage > Testing

Just import:

```haxe
import sneaker.unit_test.Tester.*;
```

### Runtime settings

```haxe
import sneaker.unit_test.TesterSettings;
```

And assign your custom values following the comments.


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
