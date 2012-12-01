// Copyright (c) 2012 Solvr, Inc. All rights reserved.
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
  
  ///
  bool debugEnabled;
  ///
  bool errorEnabled;
  ///
  bool infoEnabled;
  ///
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
