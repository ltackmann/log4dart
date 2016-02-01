// Copyright (c) 2013, the project authors. Please see the AUTHORS file
// for details. All rights reserved. Use of this source code is governed
// by a Apache license that can be found in the LICENSE file.

/** Run every log4dart test */
library log4dart_test_all;

import 'config_test.dart' as config_test;
import 'logging_test.dart' as logging_test;
import 'src/test_utils.dart';

main() {
  var appender = getTestAppender();
  config_test.runTest(appender);
  logging_test.runTest(appender);
}
