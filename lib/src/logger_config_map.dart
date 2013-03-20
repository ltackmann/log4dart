// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

class LoggerConfigMap {
  LoggerConfigMap()
    : _configs = new Map<String, LoggerConfig>();

  /**
   * Get [LoggerConfig] for [Logger] named [loggerName]
   */
  LoggerConfig operator [](String loggerName) {
    // TODO switch to regex
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
