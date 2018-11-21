/* This is free and unencumbered software released into the public domain. */

import 'package:flutter_android/android_database.dart' show MatrixCursor;
import 'package:meta/meta.dart' show experimental, required;

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

  @override
  bool moveToNext() {
    return (getPosition() < getCount() - 1) && move(1); // TODO: fix this upstream
  }
}
