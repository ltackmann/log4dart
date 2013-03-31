// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

/** Appenders does the actual logging */
abstract class Appender {
  /** Log a message */
  append(String message) {
    _doAppend(message);
    _lastMessage = message;
    _messageCount++;
  }
  
  /** Number of messages appended */
  int get messageCount => _messageCount;
  
  /** The last message appended */
  String get lastMessage => _lastMessage;
  
  /* method that does the actual appending, implemented by each concrete appender */
  _doAppend(String message);
  
  int _messageCount = 0;
  String _lastMessage;
}
