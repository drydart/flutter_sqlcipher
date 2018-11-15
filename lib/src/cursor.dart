/* This is free and unencumbered software released into the public domain. */

import 'dart:async' show Future;

import 'package:flutter/services.dart' show MethodChannel;
import 'package:flutter_android/android_database.dart' show Cursor, CursorIndexOutOfBoundsException;
import 'package:meta/meta.dart' show experimental, required;

/// Exposes results from a query on a [SQLiteDatabase].
///
/// [SQLiteCursor] is not internally synchronized so code using a [SQLiteCursor]
/// from multiple threads should perform its own synchronization when using the
/// [SQLiteCursor].
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteCursor
class SQLiteCursor extends Cursor {
  static const MethodChannel _channel = MethodChannel('flutter_sqlcipher/SQLiteCursor');

  bool _isClosed = false;
  List<String> _columns = const <String>[];
  List<List<dynamic>> _rows = const <List<dynamic>>[];
  int _rowIndex = -1;

  /// Constructs an empty cursor.
  SQLiteCursor.empty();

  /// Constructs a cursor from the provided column/row data.
  @experimental
  SQLiteCursor.from({@required List<String> columns, @required List<List<dynamic>> rows})
    : assert(columns != null),
      assert(rows != null),
      _columns = List.unmodifiable(columns),
      _rows = rows;

  @override
  Future<void> close() {
    _isClosed = true;
    _columns = null;
    _rows = null;
    _rowIndex = -1;
    return Future.value();
  }

  @override
  dynamic get(final int columnIndex) {
    if (_rowIndex < 0 || _rowIndex >= _rows.length) {
      throw CursorIndexOutOfBoundsException(_rowIndex, _rows.length);
    }
    if (columnIndex < 0 || columnIndex >= _columns.length) {
      throw CursorIndexOutOfBoundsException(columnIndex, _columns.length);
    }
    return _rows[_rowIndex][columnIndex];
  }

  @override
  List<String> getColumnNames() => _columns;

  @override
  int getCount() => _rows.length;

  @override
  int getPosition() => _rowIndex;

  @override
  bool get isClosed => _isClosed;

  @override
  bool moveToPosition(final int position) {
    if (position >= -1 && position <= _rows.length) {
      _rowIndex = position;
      return true; // request accepted
    }
    return false; // request rejected
  }
}
