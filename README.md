Log4Dart
========
**Log4Dart** is a logger for Dart inspired by [Slf4J][slf4j]. It supports
logging at ERROR, WARN, INFO and DEBUG levels and has easy support for
configuring specific appenders and logging formats. It also supports a nested
diagnostic context that allows you to eassly make session specific log traces
accross deep and recursive calls. 

Currently the following appenders are included

  * **ConsoleAppender** Appender that logs to the console
  * **FileAppender** Appender that logs to a file
  * **StringAppender** Appender that logs to a string buffer 

Getting started
---------------
The logger is accessed through  the **LoggerFactory** 

```
class MyClass {
  final Logger _logger;

  MyClass(): _logger = LoggerFactory.getLogger("MyClass");

  someMethod() {
    _logger.info("a info message");
  }
}
```

Log configuration
-----------------
The logger is configured through the LogConfig API that can be accessed
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
  
// Use a file appedender for a specifc logger
LoggerFactory.config["OtherClass"].appenders = [new FileAppender("/tmp/log.txt")];
}; 
```

For log formating **log4dart** supports many of the same options as is known
from other loggers, such as:

 * **c** Output the level (category) of the logging event
 * **d** Output the date when the log message was recorded
 * **m** Output the actual logging message
 * **n** Output the name of the logger that recorded the log
 * **x** Output the context of the logger

For more information see the **TestRunner.dart** class in the **test** folder


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

A running example of this can be seen in the **ContextLogTest.dart** class in the **test** folder.

TODO
----
Some missing stuff (feel free to add more):

  1. Generate DartDoc for Logger and Appender interface
  1. Create a Dart version of **sprintf** and use it for implementing the formatters 
  1. When reflection arrives in Dart add ability to show the class/line where the log message originated

feel free to send in patched for these (or other features you miss).

License
-------
BSD License (Same as Dart itself). See LICENSE file.  

[slf4j]: http://www.slf4j.org/
