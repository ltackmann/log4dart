// Copyright (c) 2013-2015, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

library log4dart_test;

import 'src/config_test.dart';
import 'src/logging_test.dart';

import 'package:log4dart/log4dart_vm.dart'; 

main() {
  var appender = getTestAppender();
  new ConfigTest(appender); 
  new LoggingTest(appender);
}

StringAppender getTestAppender() {
  StringAppender appender = new StringAppender();
  // Set defaults
  LoggerFactory.config[".*"].debugEnabled = false;
  LoggerFactory.config[".*"].logFormat = "[%d] %c %N:%x %m";
  LoggerFactory.config[".*"].appenders = [appender];
  // Override defaults for logger named 'NamedLogger'
  LoggerFactory.config["NamedLogger"].debugEnabled = true;
  LoggerFactory.config["NamedLogger"].infoEnabled = false;
  LoggerFactory.config["NamedLogger"].logFormat = "%c %n: %m";
  // Override defaults for logger's matching '.*MyClass'
  LoggerFactory.config[".*MyClass"].debugEnabled = true;
  LoggerFactory.config[".*MyClass"].warnEnabled = false;
  LoggerFactory.config[".*MyClass"].errorEnabled = false;
  
  return appender;
}