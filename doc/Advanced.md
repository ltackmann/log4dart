Log4Dart: Advanced Features
===========================

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