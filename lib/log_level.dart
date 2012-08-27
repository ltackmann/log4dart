// Copyright (c) 2012 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

class LogLevel {
  const LogLevel(this.name);
  
  static final DEBUG = const LogLevel("debug");
  static final ERROR = const LogLevel("error");
  static final INFO = const LogLevel("info");
  static final WARN = const LogLevel("warn");
  
  final String name;  
}
