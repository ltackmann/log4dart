// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

/**
 * Appender that logs to a [String]
 */
class StringAppender extends Appender {
  StringAppender()
    : _stringBuffer = new StringBuffer();

  void doAppend(String message) {
    _stringBuffer.add(message);
    _messageCount++;
  }

  /**
   * Content stored in appender
   */
  String get content => _stringBuffer.toString();

  /**
   * Clear the content
   */
  clear() {
    _stringBuffer.clear();
    _messageCount = 0;
  }
  
  /**
   * True when appender is empty
   */
  bool get isEmpty => content.isEmpty && messageCount == 0;
  
  final StringBuffer _stringBuffer;
}

