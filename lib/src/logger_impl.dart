// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

/**
 * Logger implementation with multiple appender and diagnostic support.
 *
 * Defaults to console logging with "[%d] %c %n:%x %m" as log format
 */
class LoggerImpl implements Logger {
   static Map<String, String> _context;

   LoggerImpl(this.name, this._config) {
     if(_context == null) {
       _context = new LinkedHashMap();
     }
     _formatter = new LogRecordFormatter(_config.logFormat);

     debugEnabled = _config.debugEnabled;
     errorEnabled = _config.errorEnabled;
     infoEnabled = _config.infoEnabled;
     warnEnabled = _config.warnEnabled;
   }

   debug(String message) {
     if(debugEnabled) _append(message, LogLevel.DEBUG);
   }

   debugFormat(String format, var args) {
     if(debugEnabled) debug(_format(format, args));
   }

   error(String message) {
     if(errorEnabled) _append(message, LogLevel.ERROR);
   }

   errorFormat(String format, var args) {
     if(errorEnabled) error(_format(format, args));
   }

   info(String message) {
     if(infoEnabled) _append(message, LogLevel.INFO);
   }

   infoFormat(String format, var args) {
     if(infoEnabled) info(_format(format, args));
   }

   warn(String message) {
     if(warnEnabled) _append(message, LogLevel.WARN);
   }

   warnFormat(String format, var args) {
     if(warnEnabled) warn(_format(format, args));
   }

   void clearContext() => _context.clear();

   String getContect(String key) => _context[key];

   void putContext(String key, String val) {
     _context[key] = val;
   }

   void removeContext(String key) {
     _context.remove(key);
   }

   void _append(String message, LogLevel level) {
     String ctx = "";
     if(_formatter.recordContext) {
      _context.forEach((k,v) => ctx = ctx.concat("$v:"));
     }
     var logRecord = new LogRecord(message, level, name, ctx);
     var formattetMessage = _formatter.format(logRecord);
     _config.appenders.forEach((Appender appender) => appender.doAppend(formattetMessage));
   }

   String _format(String format, var args) => sprintf(format, args);

   bool debugEnabled;
   bool errorEnabled;
   bool infoEnabled;
   bool warnEnabled;
   final String name;

   final LoggerConfig _config;
   LogRecordFormatter _formatter;
}
