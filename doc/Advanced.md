Log4Dart: Advanced Features
===========================

Diagnostic support
------------------
Log4Dart supports nested diagnostic contexts which can be used to trace application state

```dart
login(username, password) {
   // resolve user from username and password
   // :
   User user = :
   
   // log messages from now on are prefixed with the user id
   logger.putContext("user-context", user.id);
}

logout() {
  // stop tracking the user-context
  logger.removeContext("context-name");
}
```

See the **log4dart_test.dart** class in the **test** folder for a full example of using the diagnostic context.
