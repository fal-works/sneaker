# sneaker

May or may not help you to debug.

## Compatibility

- Haxe v4.0.5
- HashLink v1.10

## Features

- Assertion
- Logging
- Testing (quite naive)

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
|`sneaker_print_buffer_disable`|Disables using buffer in `Print.println()`.|
|`sneaker_print_last_disable`|Disables saving last buffered/printed string.|
