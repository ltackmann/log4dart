// Copyright (c) 2012 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

/**
 * Logger that depends on VM functionality (file access). 
 * 
 * Use log4dart.dart if you need client access
 */ 
library log4dart_file;

import "dart:io";
import "log4dart.dart";
export "log4dart.dart";

part "src/appenders/file_appender.dart";


