/* This is free and unencumbered software released into the public domain. */

import 'package:flutter_android/android_database.dart' show SQLException;

export 'package:flutter_android/android_database.dart' show SQLException;

/// A SQLite exception that indicates there was an error with SQL parsing or
/// execution.
class SQLiteException extends SQLException {}

/// An exception that indicates that the SQLite program was aborted.
class SQLiteAbortException extends SQLiteException {}

/// An exception that indicates that an integrity constraint was violated.
class SQLiteConstraintException extends SQLiteException {}

/// An exception that indicates that the SQLite database file is corrupt.
class SQLiteDatabaseCorruptException extends SQLiteException {}

/// An exception that indicates that an IO error occured while accessing the
/// SQLite database file.
class SQLiteDiskIOException extends SQLiteException {}

/// An exception that indicates that the SQLite program is done.
class SQLiteDoneException extends SQLiteException {}

/// An exception that indicates that the SQLite database is full.
class SQLiteFullException extends SQLiteException {}

/// This error can occur if the application creates a [SQLiteStatement] object
/// and allows multiple threads in the application use it at the same time.
class SQLiteMisuseException extends SQLiteException {}
