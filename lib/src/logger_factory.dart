// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

/**
 * Utility class for producing Loggers for various logging implementations
 *
 * Unless otherwise specified it defaults to the bundled [LoggerImpl]
 */
class LoggerFactory {
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

  /**
   * Get a [Logger] named [loggerName]
   */
  static Logger getLogger(var loggerName) {
    // TODO switch to fully qualified name when dart2js supports mirrors
    // TODO this code is duplicated in [LoggerConfigMap] make a top level function for this
    if(loggerName is String) {
      return _getLogger(loggerName);
    } else if(loggerName is Type) {
      return _getLogger(loggerName.toString());
    }
    throw new ArgumentError("unexpected type ${loggerName.runtimeType.toString()}");
  }
  
  static Logger _getLogger(String name) {
    if(_builder == null) {
      // no builder exists, default to LoggerImpl
      _builder = (n,c) => new LoggerImpl(n,c);
    }
    if(_loggerCache == null) {
      _loggerCache = new Map<String, Logger>();
    }
    if(!_loggerCache.containsKey(name)) {
      var loggerConfig = config[name];
      _loggerCache[name] = _builder(name, loggerConfig);
    }
    Logger logger = _loggerCache[name];
    assert(logger != null);
    return logger;
  }
  
  /**
   * Access and configure the log subsystem
   */
  static LoggerConfigMap get config {
    if(_configMap == null) {
      _configMap = new LoggerConfigMap();
    }
    return _configMap;
  }

  static LoggerConfigMap _configMap;
  static Map<String, Logger> _loggerCache;
  static LoggerFactory _instance;
  static LoggerBuilder _builder;
}

/**
 * Function invoked by the LoggerFactory that creates the actual logger for a given name
 */
typedef Logger LoggerBuilder(String loggerName, LoggerConfig config);
