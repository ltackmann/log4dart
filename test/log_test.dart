// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart_test;

class LogTest {
  LogTest() {
    // TODO switch to use mocking library instead
    var stringAppender = new StringAppender();
    // Global logger defaults
    LoggerFactory.config["*"].infoEnabled = false;
    LoggerFactory.config["*"].logFormat = "[%d] %c %n:%x %m";
    LoggerFactory.config["*"].appenders = [stringAppender];
    
    group("log setup -", () {
      // override settings for this logger
      LoggerFactory.config["BasicLogTest"].debugEnabled = false;
      LoggerFactory.config["BasicLogTest"].infoEnabled = true;
      // TODO override format
      
      setUp(() => stringAppender.clear());

      test("assert that overrides are applied correctly", () {
        var logger = LoggerFactory.getLogger("BasicLogTest");
        
        logger.debug("a debug message");
        expect(stringAppender.isEmpty, isTrue, reason:"debug is disabled");

        logger.info("a info message");
        expect(stringAppender.messageCount, equals(1), reason:"first log message");
        expect(stringAppender.content, matches(r"^\[.*\] INFO BasicLogTest: a info message"), reason:"info is enabled via override");

        logger.warnFormat("%s %s %s", ["a formated", "warn", "message"]);
        expect(stringAppender.messageCount, equals(2), reason:"second log message");
        expect(stringAppender.content, matches(r".*\[.*\] WARN BasicLogTest: a formated warn message"), reason:"content formatting should be correct");
      });
      
      test("assert that overrides are not applied globally", () {
        var logger = LoggerFactory.getLogger("AnotherLogger");
        
        logger.info("a info message");
        expect(stringAppender.isEmpty, isTrue, reason:"info is disabled globally");
        
        logger.debug("a debug message");
        expect(stringAppender.content, matches(r"^\[.*\] DEBUG AnotherLogger: a debug message"), reason:"debug is enabled by default");
        
        logger.warn("a warn message");
        expect(stringAppender.content, matches(r".*\[.*\] WARN AnotherLogger: a warn message"), reason:"warn is enabled by default");
        
        logger.error("a error message");
        expect(stringAppender.content, matches(r".*\[.*\] ERROR AnotherLogger: a error message"), reason:"error is enabled by default");
      });
    });
  
    group("context logging -", () {
      var logger = LoggerFactory.getLogger("ContextLogTest");
      
      setUp(() => stringAppender.clear());
      
      test("assert that contexts are added to messages", () {
        // add a context used by all loggers from this point on
        logger.putContext("context", "context-message");
        try {
          logger.debug("started tracking context");
          expect(stringAppender.content, matches(r"\[.*\] DEBUG ContextLogTest:context-message: started tracking context"), reason:"context must be added");
        } finally {
          // remove context
          logger.removeContext("context");
        }
        
        // the context is removed and should no longer be added to messages
        logger.debug("a debug message");
        expect(stringAppender.content, matches(r".*\[.*\] DEBUG ContextLogTest: a debug message"), reason:"context should no longer be added");
      });
    });
    
    group("file logging", () {
      LoggerFactory.config["FileLogTest"].appenders = [new FileAppender("/tmp/log.txt")];
      // TODO test that log messages are also written to file
    });
  }
}
