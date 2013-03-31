[![Build Status](https://drone.io/github.com/ltackmann/log4dart/status.png)](https://drone.io/github.com/ltackmann/log4dart/latest)

Log4Dart
========
Powerful logging library with support for multiple appenders, configurable formatting and log tracing.

Using log4dart
--------------
To use Log4Dart add the following to your **pubspec.yaml** file

```yaml
dependencies:
  log4dart: any
```

and install it by executing **pub install**. Then in your Dart program add one of the imports


```dart
// for client side logging (works both on the VM and when compiled to JS)
import "package:log4dart/log4dart.dart";

// for VM logging, allows you to log to files (does not compile to JS) 
import "package:log4dart/log4dart_vm.dart";
```

Now you are ready to use **log4dart**. The example below shows you how
to use it in your code.

```dart
class MyClass {
  final _logger = LoggerFactory.getLoggerFor(MyClass);

  someMethod() {
    _logger.info("a info message");
    
    _logger.warnFormat("%s %s", ["message", "formatting"]);
  }
}
```

You can retrieve loggers using in one of these two ways

 1. **LoggerFactory.getLoggerFor(MyClass)** - create logger with the fully qualified name of MyClass
 1. **LoggerFactory.getLogger("MyClass")** - create logger with the name "MyClass"
 
Where the qualified name is the library name and type name concatenated together.  

Log configuration
-----------------
The logger is configured through the **LogConfig** API that can be accessed
by logger name or wildcard via the **LoggerFactory.config["logger-name"]**
handle. Below are some examples: 

```dart
// Disable info for all loggers 
LoggerFactory.config["*"].infoEnabled = false;
  
// Set the default logging format for all loggers
LoggerFactory.config["*"].logFormat = "[%d] %c %n:%x %m";
  
// Override logging levels for specifc loggers
LoggerFactory.config["MyClass"].debugEnabled = false;
LoggerFactory.config["MyClass"].infoEnabled = true;
```

For log formating **log4dart** supports many of the same options as is known
from other loggers, such as:

 * **c** the level (category) of the logging event
 * **d** the date when the log message was recorded
 * **m** the actual logging message
 * **n** the simple name of the logger that recorded the log
 * **N** the qualified name of the logger that recorded the log
 * **x** the context of the logger

Log4Dart defaults to logging to the console but also supports various appenders 

  * **ConsoleAppender** Appender that logs to the console
  * **FileAppender** Appender that logs to a file
  * **StringAppender** Appender that logs to a string buffer 

appenders are also configured through the **LoggerFactory.config** interface 

```dart
// Use a file appender for a specifc logger
LoggerFactory.config["OtherClass"].appenders = [new FileAppender("/tmp/log.txt")];
```

to get output in multiple places, just add multiple appenders to the appenders list.


Diagnostic support
------------------
The logger supports nested diagnostic contexts which can be used to
trace application state

```dart
logger.putContext("context-name", "context-message");
try {
  // log messages from now gets added a context-message
  :
  logger.debug("something important happend");
} finally {
  // stop logging with context-message
  logger.removeContext("context-name");
}
```

See the **log4dart_test.dart** class in the **test** folder for a full example of using the diagnostic context.

[slf4j]: http://www.slf4j.org/
