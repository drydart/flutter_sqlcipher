/* This is free and unencumbered software released into the public domain. */

import 'closable.dart' show SQLiteClosable;

/// A base class for compiled SQLite programs.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteProgram
abstract class SQLiteProgram implements SQLiteClosable {
  @override
  Future<void> close() {
    return Future.value();
  }

  // TODO
}
