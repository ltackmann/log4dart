// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed 
// by a Apache license that can be found in the LICENSE file.

/**
 * Logger that depends on VM functionality (file access). 
 * 
 * Use [log4dart.dart] if you need client access
 */ 
library log4dart_vm;

import "dart:io";

import "package:meta/meta.dart";

import "log4dart.dart";
export "log4dart.dart";

part "src/appenders/file_appender.dart";


