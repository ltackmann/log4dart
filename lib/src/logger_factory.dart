// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

/**
 * Utility class for producing Loggers for various logging implementations
 *
 * Unless otherwise specified it defaults to the bundled [LoggerImpl]
 */
class LoggerFactory {
  static LoggerConfigMap _configMap;
  static Map<String, Logger> _loggerCache;
  static LoggerBuilder _builder;
  static final RegExp _nameRegex = new RegExp(r"^\w+(\.\w+)?$");

  /**
   * Assign a [LoggerBuilder] to this factory. Builders are functions that takes a name and a config
   * and creates a instance of the actual [Logger] implementations.
   *
   * Overriding the builder is only needed in the rare instances where you need to use your own
   * logger implementation rather than the default
   */
  static set logBuilder(LoggerBuilder builder) {
    _builder = builder;
  }

  /** Get a [Logger] with the fully qualified name of [type] */
  static Logger getLoggerFor(Type type) {
    /** TODO use reflectable or mirrors annotations to limit JS size */
    var cm = reflectClass(type);
    var loggerName = MirrorSystem.getName(cm.qualifiedName);
    return getLogger(loggerName);
  }

  /** Get a [Logger] named [loggerName] */
  static Logger getLogger(String loggerName) {
    if(!_nameRegex.hasMatch(loggerName)) {
      throw new ArgumentError("illegal logger name $loggerName, only letters, underscores and dots allowed");
    }
    if(_builder == null) {
      // if no builder exists, default to LoggerImpl
      _builder = (n,c) => new LoggerImpl(n,c);
    }
    if(_loggerCache == null) {
      _loggerCache = new Map<String, Logger>();
    }
    if(!_loggerCache.containsKey(loggerName)) {
      var loggerConfig = config.getConfigFor(loggerName);
      _loggerCache[loggerName] = _builder(loggerName, loggerConfig);
    }
    Logger logger = _loggerCache[loggerName];
    assert(logger != null);
    return logger;
  }

  /** Access and configure the log subsystem */
  static LoggerConfigMap get config {
    if(_configMap == null) {
      _configMap = new LoggerConfigMap();
    }
    return _configMap;
  }
}

/**
 * Function invoked by the LoggerFactory that creates the actual logger for a given name
 */
typedef Logger LoggerBuilder(String loggerName, LoggerConfig config);
