[![Build Status](https://drone.io/github.com/ltackmann/log4dart/status.png)](https://drone.io/github.com/ltackmann/log4dart/latest)

Log4Dart
========
Powerful logging library for Dart with support for multiple appenders, configurable formatting 
and log tracing using diagnostic contexts. 

Using log4dart
--------------
To use Log4Dart add the following to your **pubspec.yaml** file

```
dependencies:
  log4dart: any
```

and install it by executing **pub install**. Then in your Dart program add one of the imports


```
// for client side logging (works both on the VM and when compiled to JS)
import "package:log4dart/log4dart.dart";

// for VM logging, allows you to log to files (does not compile to JS) 
import "package:log4dart/log4dart_vm.dart";
```

Now you are ready to use **log4dart**. The example below shows you how
to use it in your code.

```
class MyClass {
  MyClass()
    : _logger = LoggerFactory.getLoggerFor(MyClass);

  someMethod() {
    _logger.info("a info message");
    
    _logger.warnFormat("%s %s", ["a warning message", "formated using c's sprintf syntax"]);
  }
  
  final Logger _logger;
}
```

You can retrieve loggers using in one of these two ways

 1. LoggerFactory.getLoggerFor(MyClass) - uses fully qualified name of MyClass
 1. LoggerFactory.getLogger("MyClass") - uses custom name "MyClass"
 
Where the qualified name is the library name and type name concatenated together.  

Log configuration
-----------------
The logger is configured through the **LogConfig** API that can be accessed
by logger name or wildcard via the **LoggerFactory.config["logger-name"]**
handle. Below are some examples: 

```
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

```
// Use a file appender for a specifc logger
LoggerFactory.config["OtherClass"].appenders = [new FileAppender("/tmp/log.txt")];
```

to get output in multiple places, just add multiple appenders to the appenders list.


Diagnostic support
------------------
The logger supports nested diagnostic contexts which can be used to
track application state like this

```
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

A running example of this can be seen in the **context_log_test.dart** class in the **test** folder.

TODO
----
Some missing stuff (feel free to add more):

  1. Generate DartDoc for Logger and Appender classes
  1. Create a Dart version of **sprintf** and use it for implementing the formatters 
  1. When reflection arrives in Dart add ability to show the class/line where the log message originated

feel free to send in patched for these (or other features you miss).

License
-------
BSD License (Same as Dart itself). See LICENSE file.  

[slf4j]: http://www.slf4j.org/
