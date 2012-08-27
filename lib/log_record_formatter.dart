// Copyright (c) 2012 Solvr, Inc. All rights reserved.
//
// This open source software is governed by the license terms 
// specified in the LICENSE file

/**
 * - c: Output the level (category) of the logging event
 * - d: Output the date when the log message was recorded
 * - m: Output the actual logging message
 * - n: Output the name of the logger that recorded the log
 * - x: Output the context of the logger
 * 
 * Default layout is: "%c [%d] %n:%x %m"
 */ 
class LogRecordFormatter {
  LogRecordFormatter(String _logFormat)
    : recordContext = false 
  {
    _formatReader = new _LogFormatReader(_logFormat);
    _parseLogFormat();
  }
  
  _parseLogFormat() {
    while(_peek() != "") {
      _currentChar = _read(); 
      if(_currentChar == " ") {
        _parseSpace();
      } else if(_currentChar == "%") {
        // we have a punctuator
        _currentChar = _read();
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
          throw new IllegalArgumentException("illegal format ${_currentChar} in ${_formatReader.toString()}");
        }
      } else {
        _parseText();      
      }
    }
  }
  
  _parseSpace() {
    String space = " ";
    while(_peek() == " ") {
      _read();
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
     while(_peek() != "%") {
       text = text.concat(_read());
     }
     _formatters.add((LogRecord record) => text);
  }
  
  String _peek([int distance = 0]) => _formatReader.peek(distance);
      
  String _read() => _formatReader.advance();
  
  bool _isPunctuator(s) => @"cdnxm".indexOf(s) != -1;
  
  String format(LogRecord record) {
    _formatters.forEach((_RecordFormatter formatter) => formatter(record));
  }

  String _currentChar;
  _LogFormatReader _formatReader;
  List<_RecordFormatter> _formatters;
  bool recordContext;
}

typedef String _RecordFormatter(LogRecord record);

