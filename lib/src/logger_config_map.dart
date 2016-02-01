// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

/** Stores and resolves [LoggerConfig]'s based on [Logger] names */
class LoggerConfigMap {
  LoggerConfigMap() {
    // default config
    var defaults = new LoggerConfig(_defaultConfig);
    defaults.debugEnabled = true;
    defaults.errorEnabled = true;
    defaults.infoEnabled = true;
    defaults.warnEnabled = true;
    defaults.appenders = [ new ConsoleAppender() ];
    defaults.logFormat = "[%d] %c %n:%x %m";

    _addConfig(defaults);
  }

  /** Get or create a [LoggerConfig] for [name] */
  LoggerConfig operator [](String name) {
    if(_getConfig(name) == null) {
      var defaults = _getConfig(_defaultConfig);
      _addConfig(defaults.cloneAs(name));
    }
    return _getConfig(name);
  }

  /**
   * Get a [LoggerConfig] for [loggerName] by first searching for direct matches, if none is found
   * then use stored logger configurations as regular expressions and return the longest match. If
   * none matches then the default log configuration is returned.
   */
  LoggerConfig getConfigFor(String loggerName) {
    LoggerConfig config;
    if(_getConfig(loggerName) != null) {
      config = _getConfig(loggerName);
    } else {
      // get longest match
      config = _sortedConfigs.firstWhere((cfg) => cfg.match(loggerName));
    }
    assert(config != null);
    return config;
  }

  _addConfig(LoggerConfig cfg) {
    _configs[cfg.name] = cfg;
    // TODO use a sorted set when it arrives in dart:collection
    _sortedConfigs.add(cfg);
    _sortedConfigs.sort();
  }

  LoggerConfig _getConfig(String matcher) => _configs[matcher];

  final List<LoggerConfig> _sortedConfigs = new List<LoggerConfig>();
  final Map<String, LoggerConfig> _configs = new Map<String, LoggerConfig>();
  final String _defaultConfig = r".*";
}
