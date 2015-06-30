// Copyright (c) 2013-2015, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

library log4dart_config_test;

import "package:test/test.dart";
import 'package:log4dart/log4dart_vm.dart';

class ConfigTest {
  ConfigTest(StringAppender appender) {

    group("config -", () {
      test("legal logger names", () {
        expect(LoggerFactory.getLogger("MyClass"), isNotNull);
        expect(LoggerFactory.getLogger("mylib.MyClass"), isNotNull);
        expect(LoggerFactory.getLogger("my_lib.MyClass"), isNotNull);
      });
      
      test("illegal logger names", () {
        expectNameError("My Class");
        expectNameError("my-lib.MyClass");
        expectNameError("*.MyClass");
      });
    
      test("default configuration", () {
        var cfg = LoggerFactory.config.getConfigFor("DefaultLogger");
        
        expect(cfg.name, equals(".*"));
        expect(cfg.debugEnabled, isFalse);
        expect(cfg.infoEnabled, isTrue);
        expect(cfg.warnEnabled, isTrue);
        expect(cfg.errorEnabled, isTrue);
        expect(cfg.logFormat, equals("[%d] %c %N:%x %m"));
      });
      
      test("overwritten configuration", () {
        var cfg = LoggerFactory.config.getConfigFor("NamedLogger");
        
        expect(cfg.name, equals("NamedLogger"));
        expect(cfg.debugEnabled, isTrue);
        expect(cfg.infoEnabled, isFalse);
        expect(cfg.warnEnabled, isTrue);
        expect(cfg.errorEnabled, isTrue);
        expect(cfg.logFormat, equals("%c %n: %m"));
      });
      
      test("regex configuration", () {
        var cfg = LoggerFactory.config.getConfigFor("log4dart_test.MyClass");
        
        expect(cfg.name, equals(".*MyClass"));
        expect(cfg.debugEnabled, isTrue);
        expect(cfg.infoEnabled, isTrue);
        expect(cfg.warnEnabled, isFalse);
        expect(cfg.errorEnabled, isFalse);
        expect(cfg.logFormat, equals("[%d] %c %N:%x %m"));
      });
    });
  }
  
  expectNameError(String loggerName) {
    bool throwed = false;
    try {
      LoggerFactory.getLogger(loggerName);
    } on ArgumentError catch(e) {
      throwed = true;
    }
    expect(throwed, isTrue, reason:"$loggerName is illegal but no error was detected");
  }
}

