/* This is free and unencumbered software released into the public domain. */

import 'package:flutter_android/android_database.dart' show SQLException;

export 'package:flutter_android/android_database.dart' show SQLException;

/// A SQLite exception that indicates there was an error with SQL parsing or
/// execution.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteException
class SQLiteException extends SQLException {}

/// An exception that indicates that the SQLite program was aborted.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteAbortException
class SQLiteAbortException extends SQLiteException {}

/// An exception that indicates that an integrity constraint was violated.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteConstraintException
class SQLiteConstraintException extends SQLiteException {}

/// An exception that indicates that the SQLite database file is corrupt.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabaseCorruptException
class SQLiteDatabaseCorruptException extends SQLiteException {}

/// An exception that indicates that an IO error occured while accessing the
/// SQLite database file.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDiskIOException
class SQLiteDiskIOException extends SQLiteException {}

/// An exception that indicates that the SQLite program is done.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDoneException
class SQLiteDoneException extends SQLiteException {}

/// An exception that indicates that the SQLite database is full.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteFullException
class SQLiteFullException extends SQLiteException {}

/// This error can occur if the application creates a [SQLiteStatement] object
/// and allows multiple threads in the application use it at the same time.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteMisuseException
class SQLiteMisuseException extends SQLiteException {}
