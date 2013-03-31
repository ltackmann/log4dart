// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

import 'package:log4dart/log4dart_vm.dart';

main() {
  // setup log levels and format
  LoggerFactory.config["MyClass"].debugEnabled = false; 
  LoggerFactory.config["MyClass"].logFormat = "(%c) %c %n %m"; 
  LoggerFactory.config["MyClass"].appenders = [ new FileAppender("/tmp/test.log"), new ConsoleAppender() ]; 
  
  // run example
  var my = new MyClass();
  my.someMethod();
}

class MyClass {
  final _logger = LoggerFactory.getLogger("MyClass");
  
  someMethod() {
    _logger.info("a info message");
    
    _logger.warnFormat("%s %s", ["message", "formatting"]);
  }
}

