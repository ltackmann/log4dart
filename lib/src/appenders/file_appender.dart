// Copyright (c) 2013 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart_file;

/**
 * Appender that logs to a file
 */
class FileAppender extends Appender {
  /**
   * Appender that logs to file in [_path]. If the file exists then its appended to.
   */
  FileAppender(this._path)
    : super();
  
  /**
   * Appender that logs to file at [path]. If the file exists then its cleared.
   */
  factory FileAppender.reset(String path) {
    // TODO create file appender that resets the log file
  }

  void doAppend(String message) {
    // TODO inneficient to open file for each log message, however I am not aware of
    // any ways to register methods to be exectued when the program shuts down
    File file = new File(_path);
    file.openSync(FileMode.APPEND).writeString("$message\n");
  }

  final String _path;
}

