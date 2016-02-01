// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed
// by a Apache license that can be found in the LICENSE file.

part of log4dart;

class LogLevel {
  const LogLevel(this.name);

  static final DEBUG = const LogLevel("DEBUG");
  static final ERROR = const LogLevel("ERROR");
  static final INFO = const LogLevel("INFO");
  static final WARN = const LogLevel("WARN");

  final String name;
}
