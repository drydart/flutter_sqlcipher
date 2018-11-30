/* This is free and unencumbered software released into the public domain. */

import 'package:flutter_android/android_database.dart' show Cursor, MatrixCursor;
import 'package:meta/meta.dart' show experimental, required;

import 'exceptions.dart';

/// Exposes results from a query on a [SQLiteDatabase].
///
/// [SQLiteCursor] is not internally synchronized so code using a [SQLiteCursor]
/// from multiple threads should perform its own synchronization when using the
/// [SQLiteCursor].
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteCursor
class SQLiteCursor extends MatrixCursor {
  /// Constructs an empty cursor.
  SQLiteCursor.empty()
    : super.empty();

  /// Constructs a cursor from the provided column/row data.
  @experimental
  SQLiteCursor.from({@required List<String> columns, @required List<List<dynamic>> rows})
    : super.from(columns: columns, rows: rows);

  /// Returns the value of the requested column as a boolean.
  ///
  /// See: https://www.sqlite.org/datatype3.html#boolean_datatype
  bool getBool(final int columnIndex) {
    switch (getType(columnIndex)) {
      case Cursor.FIELD_TYPE_NULL:
        return null;
      case Cursor.FIELD_TYPE_INTEGER:
        return getInt(columnIndex) != 0;
      default:
        throw SQLiteDatatypeMismatchException();
    }
  }

  /// Returns the value of the requested column as a UTC instant in time.
  ///
  /// See: https://www.sqlite.org/datatype3.html#date_and_time_datatype
  DateTime getDateTime(final int columnIndex) {
    switch (getType(columnIndex)) {
      case Cursor.FIELD_TYPE_NULL:
        return null;
      case Cursor.FIELD_TYPE_STRING:  // ISO-8601 strings ("YYYY-MM-DD HH:MM:SS.SSS")
        return DateTime.parse(getString(columnIndex)); // TODO: default timezone?
      case Cursor.FIELD_TYPE_INTEGER: // Unix time, seconds since 1970-01-01T00:00:00Z
        return DateTime.fromMillisecondsSinceEpoch(getInt(columnIndex) * 1000, isUtc: true);
      case Cursor.FIELD_TYPE_FLOAT:   // Julian day numbers
        // TODO: implement support for Julian day numbers; for now, fall through:
      default:
        throw SQLiteDatatypeMismatchException();
    }
  }
}
