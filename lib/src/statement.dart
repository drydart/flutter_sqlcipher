/* This is free and unencumbered software released into the public domain. */

import 'program.dart' show SQLiteProgram;

/// Represents a statement that can be executed against a database.
///
/// The statement cannot return multiple rows or columns, but single value
/// (1 x 1) result sets are supported.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteStatement
abstract class SQLiteStatement extends SQLiteProgram {
  // TODO
}
