// Copyright (c) 2012 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

#import("../log4dart.dart");
#import("../file_appender.dart");

#source("context_log_test.dart");
#source("simple_log_test.dart");

main() {
  // Simple logger setup
  LoggerFactory.builder = (name) => new LoggerImpl(name, infoEnabled:false); 
  
  // Advanced logger setup
  LoggerFactory.builder = (name) {
    Map<String,Logger> loggerMap = {
      "SimpleLogTest": new LoggerImpl(name, debugEnabled:false, infoEnabled:false),
      "ContextLogTest": new LoggerImpl(name, debugEnabled:true, appenders:[new FileAppender("/tmp/log.txt")])
    };
    return loggerMap[name];
  }; 
  
  new SimpleLogTest();
  new ContextLogTest();
}

