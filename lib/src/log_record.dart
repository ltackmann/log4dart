// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

/**
 * A logging event
 */ 
class LogRecord {
  LogRecord(this.message, this.logLevel, this.loggerName, this.context)
    : date = new Date.now();

  final Date date;
  final String message;
  final LogLevel logLevel;
  final String loggerName;
  final String context;
}

