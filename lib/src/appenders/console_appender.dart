// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

/**
 * Appender that logs to the console
 */
class ConsoleAppender extends Appender {
  void doAppend(String message) {
    print(message);
  }
}
