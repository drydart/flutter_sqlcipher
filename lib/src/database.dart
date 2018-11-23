/* This is free and unencumbered software released into the public domain. */

import 'dart:async' show Future;
import 'dart:ui' show Locale;

import 'package:flutter/services.dart' show MethodChannel, PlatformException;

import 'cursor.dart' show SQLiteCursor;

/// Exposes methods to manage a SQLite database.
///
/// [SQLiteDatabase] has methods to create, delete, execute SQL commands, and
/// perform other common database management tasks.
///
/// See the Notepad example application for an example of creating and
/// managing a database.
///
/// Database names must be unique within an application, not across all
/// applications.
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase
abstract class SQLiteDatabase {
  static const MethodChannel _channel = MethodChannel('flutter_sqlcipher/SQLiteDatabase');

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#CONFLICT_ABORT
  static const int CONFLICT_ABORT = 2;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#CONFLICT_FAIL
  static const int CONFLICT_FAIL = 3;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#CONFLICT_IGNORE
  static const int CONFLICT_IGNORE = 4;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#CONFLICT_NONE
  static const int CONFLICT_NONE = 0;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#CONFLICT_REPLACE
  static const int CONFLICT_REPLACE = 5;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#CONFLICT_ROLLBACK
  static const int CONFLICT_ROLLBACK = 1;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#CREATE_IF_NECESSARY
  static const int CREATE_IF_NECESSARY = 0x10000000;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#ENABLE_WRITE_AHEAD_LOGGING
  static const int ENABLE_WRITE_AHEAD_LOGGING = 0x20000000;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#MAX_SQL_CACHE_SIZE
  static const int MAX_SQL_CACHE_SIZE = 100;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#NO_LOCALIZED_COLLATORS
  static const int NO_LOCALIZED_COLLATORS = 0x00000010;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#OPEN_READONLY
  static const int OPEN_READONLY = 0x00000001;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#OPEN_READWRITE
  static const int OPEN_READWRITE = 0x00000000;

  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#SQLITE_MAX_LIKE_PATTERN_LENGTH
  static const int SQLITE_MAX_LIKE_PATTERN_LENGTH = 50000;

  /// Create a memory-backed SQLite database.
  ///
  /// Its contents will be destroyed when the database is closed.
  ///
  /// Throws an [SQLiteException] if the database cannot be created.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase.html#create(android.database.sqlite.SQLiteDatabase.CursorFactory)
  static Future<SQLiteDatabase> create({String password}) {
    return createInMemory(password: password);
  }

  /// Create a memory-backed SQLite database.
  ///
  /// Its contents will be destroyed when the database is closed.
  ///
  /// Throws an [SQLiteException] if the database cannot be created.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase.html#createInMemory(android.database.sqlite.SQLiteDatabase.OpenParams)
  static Future<SQLiteDatabase> createInMemory({String password}) {
    return openDatabase(':memory:', password: password);
  }

  /// Deletes a database including its journal file and other auxiliary files
  /// that may have been created by the database engine.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase.html#deleteDatabase(java.io.File)
  static Future<bool> deleteDatabase(final String path) {
    final Map<String, dynamic> request = <String, dynamic>{'path': path};
    return _channel.invokeMethod('deleteDatabase', request) as Future<bool>;
  }

  /// Open the database according to the specified parameters.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#openDatabase(java.lang.String,%20android.database.sqlite.SQLiteDatabase.CursorFactory,%20int)
  static Future<SQLiteDatabase> openDatabase(final String path, {String password, int flags = OPEN_READWRITE}) async {
    try {
      final Map<String, dynamic> request = <String, dynamic>{'path': path, 'password': password, 'flags': flags};
      final int id = await _channel.invokeMethod('openDatabase', request);
      return _SQLiteDatabase(id);
    }
    on PlatformException catch (error) {
      throw error; // TODO: improve error handling
    }
  }

  /// Equivalent to `openDatabase(path, flags: CREATE_IF_NECESSARY)`.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#openOrCreateDatabase(java.io.File,%20android.database.sqlite.SQLiteDatabase.CursorFactory)
  static Future<SQLiteDatabase> openOrCreateDatabase(final String path, {String password}) {
    return openDatabase(path, password: password, flags: CREATE_IF_NECESSARY);
  }

  /// The internal database identifier.
  int get id;

  /// The path to the database file.
  ///
  /// This is simply a Dart-idiomatic getter alias for [getPath()].
  Future<String> get path => getPath();

  /// The database version.
  ///
  /// This is simply a Dart-idiomatic getter alias for [getVersion()].
  Future<int> get version => getVersion();

  /// Begins a transaction in `EXCLUSIVE` mode.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#beginTransaction()
  Future<void> beginTransaction() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'mode': 'exclusive'};
    return _channel.invokeMethod('beginTransaction', request);
  }

  /// Begins a transaction in `IMMEDIATE` mode.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#beginTransactionNonExclusive()
  Future<void> beginTransactionNonExclusive() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'mode': 'immediate'};
    return _channel.invokeMethod('beginTransaction', request);
  }

  /// Ends a transaction.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#endTransaction()
  Future<void> endTransaction() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('endTransaction', request);
  }

  /// Executes a single SQL statement that is *not* a `SELECT` or any other SQL
  /// statement that returns data.
  ///
  /// It has no means to return any data (such as the number of affected rows).
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#execSQL(java.lang.String)
  Future<void> execSQL(final String sql) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'sql': sql};
    return _channel.invokeMethod('execSQL', request);
  }

  /// Gets the path to the database file.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#getPath()
  Future<String> getPath() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('getPath', request) as Future<String>;
  }

  /// Gets the database version.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#getVersion()
  Future<int> getVersion() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('getVersion', request) as Future<int>;
  }

  /// Returns true if the database is currently open.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#isOpen()
  Future<bool> get isOpen {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('isOpen', request) as Future<bool>;
  }

  /// Returns true if the database is opened as read only.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#isReadOnly()
  Future<bool> get isReadOnly {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('isReadOnly', request) as Future<bool>;
  }

  /// Returns true if write-ahead logging has been enabled for this database.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#isWriteAheadLoggingEnabled()
  Future<bool> get isWriteAheadLoggingEnabled {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('isWriteAheadLoggingEnabled', request) as Future<bool>;
  }

  /// Runs the provided SQL and returns a cursor over the result set.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#rawQuery(java.lang.String,%20java.lang.String[])
  Future<SQLiteCursor> rawQuery(final String sql, final List<String> args) async {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'sql': sql, 'args': args};
    final List<dynamic> result = await _channel.invokeMethod('rawQuery', request);
    assert(result.length == 2);
    final List<String> columns = (result[0] as List<dynamic>).cast<String>();
    final List<List<dynamic>> rows = (result[1] as List<dynamic>).cast<List<dynamic>>();
    return SQLiteCursor.from(columns: columns, rows: rows);
  }

  /// Sets the locale for this database.
  ///
  /// Does nothing if this database has the [NO_LOCALIZED_COLLATORS] flag set or
  /// was opened read-only.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#setLocale(java.util.Locale)
  Future<void> setLocale(final Locale locale) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'locale': locale.toString()};
    return _channel.invokeMethod('setLocale', request);
  }
}

class _SQLiteDatabase extends SQLiteDatabase {
  final int _id;

  _SQLiteDatabase(final int id) : _id = id;

  @override
  int get id => _id;
}
