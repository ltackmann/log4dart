// Copyright (c) 2012 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms
// specified in the LICENSE file

part of log4dart;

/**
 * A log record formatter for the given log format
 */ 
class LogRecordFormatter {
  LogRecordFormatter(String _logFormat)
    : recordContext = false,
      _formatters = new List<_RecordFormatter>()
  {
    _formatReader = new _LogFormatReader(_logFormat);
    _parseLogFormat();
  }

  _parseLogFormat() {
    while(_hasMore()) {
      _currentChar = _peek();
      _advance();
      if(_currentChar == " ") {
        _parseSpace();
      } else if(_currentChar == "%") {
        // we have a punctuator
        _currentChar = _peek();
        _advance();
        if(_currentChar == "c") {
          _parseCategory();
        } else if(_currentChar == "d") {
          _parseDate();
        } else if(_currentChar == "m") {
          _parseMessage();
        } else if(_currentChar == "n") {
          _parseName();
        } else if(_currentChar == "x") {
          recordContext = true;
          _parseContext();
        } else {
          throw new FormatException("illegal format ${_currentChar} in ${_formatReader.toString()}");
        }
      } else {
        _parseText();
      }
    }
  }

  _parseSpace() {
    String space = " ";
    while(_hasMore() && _peek() == " ") {
      _advance();
      space = space.concat(" ");
    }
    _formatters.add((LogRecord record) => space);
  }

  _parseCategory() {
    _formatters.add((LogRecord record) => record.logLevel.name);
  }

  _parseDate() {
    _formatters.add((LogRecord record) => record.date.toString());
  }

  _parseMessage() {
    _formatters.add((LogRecord record) => record.message);
  }

  _parseName() {
    _formatters.add((LogRecord record) => record.loggerName);
  }

  _parseContext() {
    _formatters.add((LogRecord record) => record.context);
  }

  _parseText() {
     String text = "${_currentChar}";
     while(_hasMore() && _peek() != "%") {
       text = text.concat(_peek());
       _advance();
     }
     _formatters.add((LogRecord record) => text);
  }

  String _peek([int distance = 0]) => _formatReader.peek(distance);

  _advance() => _formatReader.advance();

  bool _hasMore() => _peek() != "";

  /**
   * Returns the formatted version of a [LogRecord]
   */ 
  String format(LogRecord record) {
    var res = "";
    _formatters.forEach((_RecordFormatter formatter) => res = res.concat(formatter(record)));
    return res;
  }

  String _currentChar;
  _LogFormatReader _formatReader;
  bool recordContext;
  final List<_RecordFormatter> _formatters;
}

/**
 * Signature for the log record formatter 
 */ 
typedef String _RecordFormatter(LogRecord record);

/**
 * Reads format strings one token at a time
 */ 
class _LogFormatReader {
  factory _LogFormatReader(String formatString) {
    Expect.isFalse(formatString == null && formatString.isEmpty, "log format cannot be null or empty");
    return new _LogFormatReader._internal(formatString, formatString.length);
  }

  _LogFormatReader._internal(this._formatString, this._formatLength) {
    _position = 0;
  }

  String peek(int distance) {
    final int ahead = _position+distance;
    if (ahead >= _formatLength) {
      return "";
    }
    return _formatString.substring(ahead, ahead+_offset);
  }

  advance() {
    _position += _offset;
  }

  String toString() => _formatString;

  final int _offset = 1;
  final String _formatString;
  final int _formatLength;
  int _position;
}

