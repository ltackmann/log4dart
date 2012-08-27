// Copyright (c) 2012 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

#library("log4dart:console");

#import("log4dart.dart");

#source("lib/appenders/console_appender.dart");

/**
 * Appender that logs to the console
 */
interface ConsoleAppender extends Appender default _ConsoleAppender {
}
