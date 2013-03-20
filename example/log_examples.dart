// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

import 'package:log4dart/log4dart_vm.dart';

main() {
  // setup log levels and format
  LoggerFactory.config["MyClass"].debugEnabled = false; 
  LoggerFactory.config["MyClass"].logFormat = "(%c) %c %n:%x %m"; 
  LoggerFactory.config["MyClass"].appenders = [ new FileAppender("/tmp/test.log"), new ConsoleAppender() ]; 
  
  // run example
  new MyClass();
}

class MyClass {
  MyClass()
    : _logger = LoggerFactory.getLogger("MyClass")
  {
    _logger.debug("a debug message");
    _logger.info("a info message");
  }
  
  Logger _logger;
}

