/* This is free and unencumbered software released into the public domain. */

import 'dart:async' show Future;

/// An object created from a [SQLiteDatabase] that can be closed.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteClosable
abstract class SQLiteClosable {
  /// Closes this resource, relinquishing any underlying resources.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteClosable.html#close()
  Future<void> close();
}
