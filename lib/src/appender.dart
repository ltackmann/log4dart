// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

/**
 * Implemented by classes that performs the actual logging
 */
abstract class Appender {
  Appender()
    : _messageCount = 0;
  
  /**
   * Log a message.
   */
  doAppend(String message);
  
  /**
   * Number of messages logged
   */
  int get messageCount => _messageCount;
  
  int _messageCount;
}
