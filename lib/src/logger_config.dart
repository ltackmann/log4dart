// Copyright (c) 2013-2015, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

class LoggerConfig implements Comparable<LoggerConfig> {
  LoggerConfig(String configName)
    : name = configName,
      _nameRegex = new RegExp(configName);
  
  /** True if this [LoggerConfig] applies for logger named [loggerName] */
  bool match(String loggerName) => _nameRegex.hasMatch(loggerName);

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

  /** Clone this [LoggerConfig] using name [configName] */
  LoggerConfig cloneAs(String configName) {
    LoggerConfig cfg = new LoggerConfig(configName);
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
  
  /// [Appender]'s used by this [LoggerConfig]
  List<Appender> appenders;
  
  /// The name of this [LoggerConfig] 
  final String name;
  
  @override
  int compareTo(LoggerConfig other) => (other == this) ? 0 : (other.name.length).compareTo(name.length); 
  
  @override
  bool operator ==(LoggerConfig other) => (other == null) ? false : (name == other.name); 
  
  @override
  int get hashCode => name.hashCode;
  
  final RegExp _nameRegex;
}
