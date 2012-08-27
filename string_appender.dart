// Copyright (c) 2012 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

#library('log4dart:string');

#import("log4dart.dart");

#source("lib/appenders/string_appender.dart");

/**
 * Appender that logs to a [String]
 */
interface StringAppender extends Appender default _StringAppender {
  String get log();
  
  clearLog();
}

