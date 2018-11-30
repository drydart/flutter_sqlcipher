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

  /// Returns the value of the requested column as a UTC instant in time.
  ///
  /// See: https://www.sqlite.org/lang_datefunc.html
  DateTime getDateTime(final int columnIndex) {
    switch (getType(columnIndex)) {
      case Cursor.FIELD_TYPE_NULL:
        return null;
      case Cursor.FIELD_TYPE_INTEGER:
        return DateTime.fromMillisecondsSinceEpoch(getInt(columnIndex), isUtc: true);
      case Cursor.FIELD_TYPE_STRING:
        return DateTime.parse(getString(columnIndex)); // TODO: default timezone?
      default:
        throw SQLiteDatatypeMismatchException();
    }
  }
}
