// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

/** Default [Logger] implementation with multiple appender and diagnostic support. */
class LoggerImpl implements Logger {
   static Map<String, String> _context;

   factory LoggerImpl(String loggerName, LoggerConfig loggerConfig) {
     if(_context == null) {
       _context = new LinkedHashMap();
     }
     var loggerFormatter = new LogRecordFormatter(loggerConfig.logFormat);
     return new LoggerImpl._internal(loggerName, loggerConfig, loggerFormatter);
   }

   LoggerImpl._internal(this.name, this._config, this._formatter);

   @override
   debug(String message) {
     if(debugEnabled) _append(message, LogLevel.DEBUG);
   }

   @override
   debugFormat(String format, var args) {
     if(debugEnabled) debug(_format(format, args));
   }

   @override
   error(String message) {
     if(errorEnabled) _append(message, LogLevel.ERROR);
   }

   @override
   errorFormat(String format, var args) {
     if(errorEnabled) error(_format(format, args));
   }

   @override
   info(String message) {
     if(infoEnabled) _append(message, LogLevel.INFO);
   }

   @override
   infoFormat(String format, var args) {
     if(infoEnabled) info(_format(format, args));
   }

   @override
   warn(String message) {
     if(warnEnabled) _append(message, LogLevel.WARN);
   }

   @override
   warnFormat(String format, var args) {
     if(warnEnabled) warn(_format(format, args));
   }

   @override
   clearContext() => _context.clear();

   @override
   String getContext(String key) => _context[key];

   @override
   putContext(String key, String val) {
     _context[key] = val;
   }

   @override
   removeContext(String key) {
     _context.remove(key);
   }

   @override
   bool get debugEnabled => _config.debugEnabled;

   @override
   bool get errorEnabled => _config.errorEnabled;

   @override
   bool get infoEnabled => _config.infoEnabled;

   @override
   bool get warnEnabled => _config.warnEnabled;

   _append(String message, LogLevel level) {
     String ctx = "";
     if(_formatter.recordContext) {
      _context.forEach((k,v) => ctx = ctx + "$v:");
     }
     var logRecord = new LogRecord(message, level, name, ctx);
     var formattetMessage = _formatter.format(logRecord);
     _config.appenders.forEach((Appender appender) => appender.append(formattetMessage));
   }

   String _format(String format, var args) => sprintf(format, args);

   final String name;
   final LoggerConfig _config;
   final LogRecordFormatter _formatter;
}
