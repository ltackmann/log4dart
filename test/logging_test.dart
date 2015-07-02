// Copyright (c) 2013-2015, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

library log4dart_logging_test;

import "package:test/test.dart";
import 'package:log4dart/log4dart_vm.dart';

import 'src/test_utils.dart';

main() {
  var appender = getTestAppender();
  runTest(appender);
}

runTest(Appender appender) {
  new LoggingTest(appender);  
}

class LoggingTest {
  LoggingTest(StringAppender appender) {
    group("logging (basic) -", () {
      setUp(() => appender.clear());

      test("default configuration", () {
        var logger = LoggerFactory.getLogger("DefaultLogger");
        
        logger.debug("a debug message");
        expect(appender.lastMessage, isNull, reason:"debug is disabled by default");
        
        logger.infoFormat("a %s message", ["info"]);
        expect(appender.lastMessage, matches(r"INFO DefaultLogger: a info message"), reason:"info is enabled by default");
        
        logger.warn("a warn message");
        expect(appender.lastMessage, matches(r"WARN DefaultLogger: a warn message"), reason:"warn is enabled by default");
        
        logger.error("a error message");
        expect(appender.lastMessage, matches(r"ERROR DefaultLogger: a error message"), reason:"error is enabled by default");
      });
      
      test("named configuration", () {
        var logger = LoggerFactory.getLogger("NamedLogger");
        
        logger.info("a info message");
        expect(appender.isEmpty, isTrue, reason:"info is disabled by override");
        expect(appender.messageCount, equals(0), reason:"no log message should be recorded");
        
        logger.debugFormat("a %s message", ["debug"]);
        expect(appender.lastMessage, matches(r"DEBUG NamedLogger: a debug message"), reason:"debug is enabled by override");
        
        logger.warn("a warn message");
        expect(appender.lastMessage, matches(r"WARN NamedLogger: a warn message"), reason:"warn is enabled by default");
        
        logger.error("a error message");
        expect(appender.lastMessage, matches(r"ERROR NamedLogger: a error message"), reason:"error is enabled by default");
      });
      
      test("regex configuration", () {
        var logger = LoggerFactory.getLoggerFor(MyClass);
        
        logger.debug("a debug message");
        expect(appender.lastMessage, matches(r"DEBUG log4dart_logging_test.MyClass: a debug message"), reason:"debug is enabled by override");
        
        logger.info("a info message");
        expect(appender.lastMessage, matches(r"INFO log4dart_logging_test.MyClass: a info message"), reason:"info is enabled by default");
        expect(appender.messageCount, equals(2));
        
        logger.warn("a warn message");
        expect(appender.messageCount, equals(2), reason:"warn is enabled by override");
        
        logger.error("a error message");
        expect(appender.messageCount, equals(2), reason:"error is enabled by override");
      });
    });

    group("logging (context) -", () {
      var logger = LoggerFactory.getLogger("ContextLogger");
      
      setUp(() => appender.clear());
      
      test("add context to messages", () {
        // add a context used by all loggers from this point on
        logger.putContext("context", "context-message");
        try {
          logger.info("started tracking context");
          expect(appender.lastMessage, matches(r"INFO ContextLogger:context-message: started tracking context"), reason:"context must be added");
        } finally {
          // remove context
          logger.removeContext("context");
        }
        
        // the context is removed and should no longer be added to messages
        logger.info("a info message");
        expect(appender.lastMessage, matches(r"INFO ContextLogger: a info message"), reason:"context should no longer be added");
      });
    });
    
    group("logging (file) -", () {
      LoggerFactory.config["FileLogTest"].appenders = [new FileAppender("/tmp/log.txt")];
      // TODO test that log messages are also written to file
    });
  }
}

// globals used in tests
class MyClass { }


