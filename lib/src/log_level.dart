// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

class LogLevel {
  const LogLevel(this.name);

  static final DEBUG = const LogLevel("DEBUG");
  static final ERROR = const LogLevel("ERROR");
  static final INFO = const LogLevel("INFO");
  static final WARN = const LogLevel("WARN");

  final String name;
}
