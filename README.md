# sneaker

May or may not help you to debug.

## Compatibility

- Haxe v4.0.5
- HashLink v1.10

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

## Downsides

- All of this is nothing but reinventing the wheel
- Don't know much about other libraries/frameworks
- Not yet very well tested

## Usage

### Assertion

...

### Logging

...

### Testing

...

## Compilation flags

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
