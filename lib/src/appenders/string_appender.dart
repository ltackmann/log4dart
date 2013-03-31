// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

/** Appender that logs to a [String] */
class StringAppender extends Appender {
  @override
  doAppend(String message) {
    _stringBuffer.write(message);
  }

  /** Content stored in appender */
  String get content => _stringBuffer.toString();

  /** Clear content */
  clear() {
    _stringBuffer.clear();
    _messageCount = 0;
  }
  
  /** True when appender is empty */
  bool get isEmpty => content.isEmpty && messageCount == 0;
  
  final StringBuffer _stringBuffer = new StringBuffer();
}

