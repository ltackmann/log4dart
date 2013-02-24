// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

/**
 * A logging event
 */ 
class LogRecord {
  factory LogRecord(String message, LogLevel logLevel, String qualifiedLoggerName, String context) {
    var i = qualifiedLoggerName.indexOf(".");
    String simpleLoggerName = (i > -1) ? qualifiedLoggerName.slice(i+1) : qualifiedLoggerName; 
    return new LogRecord._internal(message, logLevel, context, new DateTime.now(), simpleLoggerName, qualifiedLoggerName);
  }
  
  LogRecord._internal(this.message, this.logLevel, this.context, this.date, this.simpleLoggerName, this.qualifiedLoggerName);
  
  final DateTime date;
  final LogLevel logLevel;
  final String message, context, simpleLoggerName, qualifiedLoggerName;
}

