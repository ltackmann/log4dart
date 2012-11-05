// Copyright (c) 2012 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file
library test_runner;

import "../lib/log4dart_console.dart";

part "context_log_test.dart";
part "simple_log_test.dart";

main() {
  // Disable info for all loggers
  LoggerFactory.config["*"].infoEnabled = false;

  // Set the default logging format for all loggers
  LoggerFactory.config["*"].logFormat = "[%d] %c %n:%x %m";

  // Set debug levels and format for specifc loggers
  LoggerFactory.config["SimpleLogTest"].debugEnabled = false;
  LoggerFactory.config["SimpleLogTest"].infoEnabled = true;

  // Use a file appedender for a specifc logger
  LoggerFactory.config["ContextLogTest"].appenders = [new FileAppender("/tmp/log.txt")];

  // run tests
  new SimpleLogTest();
  new ContextLogTest();
}

