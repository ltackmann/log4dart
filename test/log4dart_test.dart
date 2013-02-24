// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

library log4dart_test;

import "package:unittest/unittest.dart";
import "../lib/log4dart_vm.dart";

main() {
  // TODO switch to use mocking library instead
  var stringAppender = new StringAppender();
  // Global logger defaults
  LoggerFactory.config["*"].debugEnabled = false;
  LoggerFactory.config["*"].logFormat = "[%d] %c %N:%x %m";
  LoggerFactory.config["*"].appenders = [stringAppender];
  
  group("basic logging -", () {
    // Override settings for specific loggers so we can test that settings are used correctly
    LoggerFactory.config["OverrideLogger"].debugEnabled = true;
    LoggerFactory.config["OverrideLogger"].infoEnabled = false;
    LoggerFactory.config["OverrideLogger"].logFormat = "%c %n: %m";
    LoggerFactory.config["log4dart_test.MyClass"].debugEnabled = true;
    
    setUp(() => stringAppender.clear());

    test("default configuration", () {
      var logger = LoggerFactory.getLogger("DefaultLogger");
      
      logger.debug("a debug message");
      expect(stringAppender.isEmpty, isTrue, reason:"debug is disabled by default");
      expect(stringAppender.messageCount, equals(0), reason:"no log message should be recorded");
      
      logger.infoFormat("a %s message", ["info"]);
      expect(stringAppender.content, matches(r"^\[.*\] INFO DefaultLogger: a info message"), reason:"info is enabled by default");
      
      logger.warn("a warn message");
      expect(stringAppender.content, matches(r".*\[.*\] WARN DefaultLogger: a warn message"), reason:"warn is enabled by default");
      
      logger.error("a error message");
      expect(stringAppender.content, matches(r".*\[.*\] ERROR DefaultLogger: a error message"), reason:"error is enabled by default");
    });
    
    test("type configuration", () {
      // get a logger named after the Duration type
      var logger = LoggerFactory.getLoggerFor(MyClass);
      
      logger.debug("a debug message");
      expect(stringAppender.content, matches(r"^\[.*\] DEBUG log4dart_test.MyClass: a debug message"), reason:"debug is enabled by override");
      
      logger.info("a info message");
      expect(stringAppender.content, matches(r".*\[.*\] INFO log4dart_test.MyClass: a info message"), reason:"info is enabled by default");
    });
    
    test("configuration overrides", () {
      var logger = LoggerFactory.getLogger("OverrideLogger");
      
      logger.info("a info message");
      expect(stringAppender.isEmpty, isTrue, reason:"info is disabled by override");
      expect(stringAppender.messageCount, equals(0), reason:"no log message should be recorded");
      
      logger.debugFormat("a %s message", ["debug"]);
      expect(stringAppender.content, matches(r"DEBUG OverrideLogger: a debug message"), reason:"debug is enabled by override");
      
      logger.warn("a warn message");
      expect(stringAppender.content, matches(r".*WARN OverrideLogger: a warn message"), reason:"warn is enabled by default");
      
      logger.error("a error message");
      expect(stringAppender.content, matches(r".*ERROR OverrideLogger: a error message"), reason:"error is enabled by default");
    });
  });

  group("context logging -", () {
    var logger = LoggerFactory.getLogger("ContextLogger");
    
    setUp(() => stringAppender.clear());
    
    test("add context to messages", () {
      // add a context used by all loggers from this point on
      logger.putContext("context", "context-message");
      try {
        logger.info("started tracking context");
        expect(stringAppender.content, matches(r"\[.*\] INFO ContextLogger:context-message: started tracking context"), reason:"context must be added");
      } finally {
        // remove context
        logger.removeContext("context");
      }
      
      // the context is removed and should no longer be added to messages
      logger.info("a info message");
      expect(stringAppender.content, matches(r".*\[.*\] INFO ContextLogger: a info message"), reason:"context should no longer be added");
    });
  });
  
  group("file logging -", () {
    LoggerFactory.config["FileLogTest"].appenders = [new FileAppender("/tmp/log.txt")];
    // TODO test that log messages are also written to file
  });
}

class MyClass { }
