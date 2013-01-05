// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

/**
 * Appender that logs to a [String]
 */
class StringAppender implements Appender {
  StringAppender()
    : _stringBuffer = new StringBuffer();

  void doAppend(String message) {
    _stringBuffer.add(message);
  }

  String get log => _stringBuffer.toString();

  clearLog() => _stringBuffer.clear();

  final StringBuffer _stringBuffer;
}

