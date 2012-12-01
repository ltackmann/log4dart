// Copyright (c) 2012 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

/**
 * Implemented by classes that performs the actual logging
 */
abstract class Appender {
  /**
   * Log a message.
   */
  doAppend(String message);
}