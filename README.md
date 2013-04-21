[![Build Status](https://drone.io/github.com/ltackmann/log4dart/status.png)](https://drone.io/github.com/ltackmann/log4dart/latest)

Log4Dart
========
Logging library with multiple appenders, configurable formatting and log tracing.

Quick Guide
-----------

**1.** Add the folowing to your **pubspec.yaml** and run **pub install**
```yaml
	dependencies:
	  log4dart: any
```

**2.** Add log4dart to some code and run it
```dart
	import "package:log4dart/log4dart.dart";
	
	main() {
		var myClass = new MyClass();
		myClass.someMethod();
	}
		
	class MyClass {
		static final _logger = LoggerFactory.getLoggerFor(MyClass);
	
		someMethod() {
			_logger.info("a info message");
			// :
			_logger.warnFormat("%s %s", ["message", "formatting"]);
		}
	}
```

Getting Loggers
---------------
Log4Dart is split in multiple libraries so it can run on both servers and in browsers.

```dart
// for client side logging (works both on the VM and when compiled to JS)
import "package:log4dart/log4dart.dart";

// for VM logging, allows you to log to files (does not compile to JS) 
import "package:log4dart/log4dart_vm.dart";
```

When you want to retrieve a logger instance you can do it in one of two ways

 1. **LoggerFactory.getLoggerFor(MyClass)** - logger with the fully qualified name of MyClass
 1. **LoggerFactory.getLogger("MyClass")** - logger with the name "MyClass"
 
Where the qualified name is the library name and type name concatenated together.  

More Information
----------------
The [configuration guide](https://github.com/ltackmann/log4dart/blob/master/doc/Config.md) covers everything from 
log level setup to output formatting. For more advanced features, such as log tracing, check out the 
[advanced feature guide](https://github.com/ltackmann/log4dart/blob/master/doc/Advanced.md).

[slf4j]: http://www.slf4j.org/
