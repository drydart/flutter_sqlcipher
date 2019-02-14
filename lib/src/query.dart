/* This is free and unencumbered software released into the public domain. */

import 'program.dart' show SQLiteProgram;

/// Represents a query that reads the resulting rows into a [SQLiteQuery].
///
/// This class is used by [SQLiteCursor] and isn't useful itself.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteQuery
abstract class SQLiteQuery extends SQLiteProgram {
  // TODO
}
