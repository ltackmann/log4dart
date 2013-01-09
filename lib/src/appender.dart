// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

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
