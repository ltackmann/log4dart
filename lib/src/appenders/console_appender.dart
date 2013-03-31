// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

/** Appender that logs to the console */
class ConsoleAppender extends Appender {
  @override
  doAppend(String message) {
    print(message);
  }
}
