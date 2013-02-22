// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

class LoggerConfigMap {
  LoggerConfigMap()
    : _configs = new Map<String, LoggerConfig>();

  /**
   * Get [LoggerConfig] for [Logger] named [loggerName]
   */
  LoggerConfig operator [](var loggerName) {
    // TODO switch to fully qualified name when dart2js supports mirrors
    if(loggerName is String) {
      return _getLoggerConfig(loggerName);
    } else if(loggerName is Type) {
      return _getLoggerConfig(loggerName.toString());
    }
    throw new ArgumentError("unexpected type ${loggerName.runtimeType.toString()}");
  }
  
  LoggerConfig _getLoggerConfig(String loggerName) {
    if(!_configs.containsKey(loggerName)) {
      if(!_configs.containsKey("*")) {
        var defaultConfig = new LoggerConfig();
        defaultConfig.debugEnabled = true;
        defaultConfig.errorEnabled = true;
        defaultConfig.infoEnabled = true;
        defaultConfig.warnEnabled = true;
        defaultConfig.appenders = [ new ConsoleAppender() ];
        defaultConfig.logFormat = "[%d] %c %n:%x %m";

        _configs["*"] = defaultConfig;
      }
      var defaults = _configs["*"];
      _configs[loggerName] = defaults.clone();
    }
    return _configs[loggerName];
  }

  forEach(Function f) {
    return _configs.forEach(f);
  }

  final Map<String, LoggerConfig> _configs;
}
