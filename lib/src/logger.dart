// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

/**
 * Logger API.
 *
 * The actual logging takes place through concrete implementations of this interface.
 */
abstract class Logger {
  /** Log a message at the DEBUG level. */
  debug(String message);

  /** Log a message at the DEBUG level according to the specified format and argument. */
  debugFormat(String format, var args);

  /** Log a message at the ERROR level. */
  error(String message);

  /** Log a message at the ERROR level according to the specified format and argument. */
  errorFormat(String format, var args);

  /** Log a message at the INFO level. */
  info(String message);

  /** Log a message at the INFO level according to the specified format and argument. */
  infoFormat(String format, var args);

  /** Log a message at the WARN level. */
  warn(String message);

  /** Log a message at the WARN level according to the specified format and argument. */
  warnFormat(String format, var args);

  /** Is the logger instance enabled for the DEBUG level? */
  bool get debugEnabled;

  /** Is the logger instance enabled for the INFO level? */
  bool get infoEnabled;

  /** Is the logger instance enabled for the WARN level? */
  bool get warnEnabled;

  /** Is the logger instance enabled for the ERROR level? */
  bool get errorEnabled;

  /** Clear all entries in the diagnostic context. */
  clearContext();

  /** Return the name of this Logger instance. */
  String name;

  /** Get the diagnostic context value identified by the [key] parameter. */
  String getContext(String key);

  /** Create a diagnostic context identified as [key] that can be traced in the log output as [val] */
  putContext(String key, String val);

  /** Remove the the diagnostic context identified by the [key] parameter. */
  removeContext(String key);
}

