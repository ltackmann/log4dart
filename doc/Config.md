Log4Dart: Configuration
=======================

Logger's are configured via the **LoggerFactory.config["logger-name"]** interface. Below are some examples: 

```dart
// Disable info for all loggers 
LoggerFactory.config[".*"].infoEnabled = false;
  
// Set the default logging format for all loggers
LoggerFactory.config[".*"].logFormat = "[%d] %c %n:%x %m";
  
// Override logging levels for a specifc logger
LoggerFactory.config["MyClass"].debugEnabled = false;
LoggerFactory.config["MyClass"].infoEnabled = true;
```

as seen above logger configurations can either be bound to a specific logger name
such as **MyClass** or matched multiple loggers using a regex such as **.***

Formatting
----------
For log formatting **log4dart** supports many of the same options as is known
from other loggers, such as:

 * **c** the level (category) of the logging event
 * **d** the date when the log message was recorded
 * **m** the actual logging message
 * **n** the simple name of the logger that recorded the log
 * **N** the qualified name of the logger that recorded the log
 * **x** the context of the logger

Appenders
---------
Log4Dart logs to the console by default but also supports other appenders 

  * **ConsoleAppender** Appender that logs to the console
  * **FileAppender** Appender that logs to a file
  * **StringAppender** Appender that logs to a string buffer 

these are also configured through the **LoggerFactory.config** interface 

```dart
// Use a file appender for a specifc logger
LoggerFactory.config["OtherClass"].appenders = [new FileAppender("/tmp/log.txt")];
```

to get output in multiple places, just add multiple appenders to the appenders list.

```dart
// Use multiple file appender for a specifc logger
LoggerFactory.config["AnotherClass"].appenders = [new ConsoleAppender(), new FileAppender("/tmp/log.txt")];
```
