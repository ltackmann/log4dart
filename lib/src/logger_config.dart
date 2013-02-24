// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

class LoggerConfig {
  String toString() {
    var str = """
      debugEnabled: $debugEnabled\n
      errorEnabled: $errorEnabled\n
      infoEnabled: $infoEnabled\n
      warnEnabled: $warnEnabled\n
      format: $logFormat
    """;
    return str;
  }

  LoggerConfig clone() {
    LoggerConfig cfg = new LoggerConfig();
    cfg.debugEnabled = debugEnabled;
    cfg.errorEnabled = errorEnabled;
    cfg.infoEnabled = infoEnabled;
    cfg.warnEnabled = warnEnabled;
    cfg.logFormat = "$logFormat";
    cfg.appenders = new List.from(appenders);
    return cfg;
  }
  
  /// when true the debug log level is enabled
  bool debugEnabled;
  /// when true the error log level is enabled
  bool errorEnabled;
  /// when true the info log level is enabled
  bool infoEnabled;
  /// when true the warning log level is enabled
  bool warnEnabled;
  
  /// * **c** Output the level (category) of the logging event
  /// * **d** Output the date when the log message was recorded
  /// * **m** Output the actual logging message
  /// * **n** Output the name of the logger that recorded the log
  /// * **x** Output the context of the logger
  String logFormat;
  
  ///
  List<Appender> appenders;
}
