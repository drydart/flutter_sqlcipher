/* This is free and unencumbered software released into the public domain. */

import 'dart:async' show Future;
import 'dart:ui' show Locale;

import 'package:flutter/services.dart' show MethodChannel, PlatformException;

import 'closable.dart' show SQLiteClosable;
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
abstract class SQLiteDatabase implements SQLiteClosable {
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

  /// Attempts to release memory that SQLite holds but does not require to
  /// operate properly.
  ///
  /// Typically this memory will come from the page cache.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#releaseMemory()
  static Future<int> releaseMemory() {
    return _channel.invokeMethod('releaseMemory') as Future<int>;
  }

  /// The internal database identifier.
  int get id;

  /// The maximum size, in bytes, that the database may grow to.
  ///
  /// This is simply a Dart-idiomatic getter alias for [getMaximumSize()].
  Future<int> get maximumSize => getMaximumSize();

  /// The current database page size, in bytes.
  ///
  /// This is simply a Dart-idiomatic getter alias for [getPageSize()].
  Future<int> get pageSize => getPageSize();

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

  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#beginTransactionWithListener(android.database.sqlite.SQLiteTransactionListener)
  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#beginTransactionWithListenerNonExclusive(android.database.sqlite.SQLiteTransactionListener)

  @override
  Future<void> close() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('close', request);
  }

  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#compileStatement(java.lang.String)
  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#delete(java.lang.String,%20java.lang.String,%20java.lang.String[])

  /// This method disables the features enabled by [enableWriteAheadLogging].
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#disableWriteAheadLogging()
  Future<void> disableWriteAheadLogging() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('disableWriteAheadLogging', request);
  }

  /// This method enables parallel execution of queries from multiple threads on
  /// the same database.
  ///
  /// Returns true if write-ahead logging is enabled.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#enableWriteAheadLogging()
  Future<bool> enableWriteAheadLogging() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('enableWriteAheadLogging', request);
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
  Future<void> execSQL(final String sql, [final List<dynamic> args]) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'sql': sql, 'args': args};
    return _channel.invokeMethod('execSQL', request);
  }

  /// Returns list of full pathnames of all attached databases including the
  /// main database by executing `PRAGMA database_list` on the database.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#getAttachedDbs()
  Future<Map<String, String>> getAttachedDbs() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('getAttachedDbs', request);
  }

  /// Returns the maximum size, in bytes, that the database may grow to.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#getMaximumSize()
  Future<int> getMaximumSize() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('getMaximumSize', request) as Future<int>;
  }

  /// Returns the current database page size, in bytes.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#getPageSize()
  Future<int> getPageSize() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('getPageSize', request) as Future<int>;
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

  /// Returns true if the current thread has a transaction pending.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#inTransaction()
  Future<bool> get inTransaction {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('inTransaction', request) as Future<bool>;
  }

  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#insert(java.lang.String,%20java.lang.String,%20android.content.ContentValues)
  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#insertOrThrow(java.lang.String,%20java.lang.String,%20android.content.ContentValues)
  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#insertWithOnConflict(java.lang.String,%20java.lang.String,%20android.content.ContentValues,%20int)

  /// Runs `PRAGMA integrity_check` on the given database (and all the attached
  /// databases).
  ///
  /// Returns true if the given database (and all its attached databases) pass
  /// the integrity check, false otherwise.
  ///
  /// If the result is false, then this method logs the errors reported by the
  /// `PRAGMA integrity_check` command execution.
  ///
  /// Note that `PRAGMA integrity_check` on a database can take a long time.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#isDatabaseIntegrityOk()
  Future<bool> get isDatabaseIntegrityOk {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('isDatabaseIntegrityOk', request) as Future<bool>;
  }

  /// Returns true if the current thread is holding an active connection to the
  /// database.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#isDbLockedByCurrentThread()
  Future<bool> get isDbLockedByCurrentThread {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('isDbLockedByCurrentThread', request) as Future<bool>;
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

  /// Returns true if the new version code is greater than the current database
  /// version.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#needUpgrade(int)
  Future<bool> needUpgrade(final int newVersion) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'newVersion': newVersion};
    return _channel.invokeMethod('needUpgrade', request) as Future<bool>;
  }

  /// Query the given table, returning a [Cursor] over the result set.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#query(boolean,%20java.lang.String,%20java.lang.String[],%20java.lang.String,%20java.lang.String[],%20java.lang.String,%20java.lang.String,%20java.lang.String,%20java.lang.String)
  Future<SQLiteCursor> query({
    final bool distinct = false,
    final String table,
    final List<String> columns,
    final String where,
    final List<String> whereArgs,
    final String groupBy,
    final String having,
    final String orderBy,
    final Object limit,
  }) async {
    final Map<String, dynamic> request = <String, dynamic>{
      'id': id,
      'distinct': distinct,
      'table': table,
      'columns': columns,
      'selection': where,         // note the name mapping
      'selectionArgs': whereArgs, // note the name mapping
      'groupBy': groupBy,
      'having': having,
      'orderBy': orderBy,
      'limit': limit.toString(),
    };
    final List<dynamic> result = await _channel.invokeMethod('query', request);
    assert(result.length == 2);
    final List<String> cursorColumns = (result[0] as List<dynamic>).cast<String>();
    final List<List<dynamic>> cursorRows = (result[1] as List<dynamic>).cast<List<dynamic>>();
    return SQLiteCursor.from(columns: cursorColumns, rows: cursorRows);
  }

  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#queryWithFactory(android.database.sqlite.SQLiteDatabase.CursorFactory,%20boolean,%20java.lang.String,%20java.lang.String[],%20java.lang.String,%20java.lang.String[],%20java.lang.String,%20java.lang.String,%20java.lang.String,%20java.lang.String,%20android.os.CancellationSignal)

  /// Runs the provided SQL and returns a cursor over the result set.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#rawQuery(java.lang.String,%20java.lang.String[])
  Future<SQLiteCursor> rawQuery(final String sql, [final List<String> args]) async {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'sql': sql, 'args': args};
    final List<dynamic> result = await _channel.invokeMethod('rawQuery', request);
    assert(result.length == 2);
    final List<String> cursorColumns = (result[0] as List<dynamic>).cast<String>();
    final List<List<dynamic>> cursorRows = (result[1] as List<dynamic>).cast<List<dynamic>>();
    return SQLiteCursor.from(columns: cursorColumns, rows: cursorRows);
  }

  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#replace(java.lang.String,%20java.lang.String,%20android.content.ContentValues)
  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#replaceOrThrow(java.lang.String,%20java.lang.String,%20android.content.ContentValues)

  /// Sets whether foreign key constraints are enabled for the database.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#setForeignKeyConstraintsEnabled(boolean)
  Future<void> setForeignKeyConstraintsEnabled(final bool enable) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'enable': enable};
    return _channel.invokeMethod('setForeignKeyConstraintsEnabled', request);
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

  /// Sets the maximum size of the prepared-statement cache for this database.
  ///
  /// (Size of the cache = number of compiled-sql-statements stored in the cache.)
  ///
  /// Maximum cache size can *only* be increased from its current size (default =
  /// 10). If this method is called with smaller size than the current maximum
  /// value, then an exception is thrown.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#setMaxSqlCacheSize(int)
  Future<void> setMaxSqlCacheSize(final int cacheSize) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'cacheSize': cacheSize};
    return _channel.invokeMethod('setMaxSqlCacheSize', request);
  }

  /// Sets the maximum size the database will grow to.
  ///
  /// The maximum size cannot be set below the current size.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#setMaximumSize(long)
  Future<void> setMaximumSize(final int numBytes) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'numBytes': numBytes};
    return _channel.invokeMethod('setMaximumSize', request);
  }

  /// Sets the database page size.
  ///
  /// The page size must be a power of two. This method does not work if any
  /// data has been written to the database file, and must be called right after
  /// the database has been created.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#setPageSize(long)
  Future<void> setPageSize(final int numBytes) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'numBytes': numBytes};
    return _channel.invokeMethod('setPageSize', request);
  }

  /// Marks the current transaction as successful.
  ///
  /// Do not do any more database work between calling this and calling
  /// endTransaction. Do as little non-database work as possible in that
  /// situation too. If any errors are encountered between this and
  /// endTransaction the transaction will still be committed.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#setTransactionSuccessful()
  Future<void> setTransactionSuccessful() {
    final Map<String, dynamic> request = <String, dynamic>{'id': id};
    return _channel.invokeMethod('setTransactionSuccessful', request);
  }

  /// Sets the database version.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#setVersion(int)
  Future<void> setVersion(final int version) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'version': version};
    return _channel.invokeMethod('setVersion', request);
  }

  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#update(java.lang.String,%20android.content.ContentValues,%20java.lang.String,%20java.lang.String[])
  // TODO: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#updateWithOnConflict(java.lang.String,%20android.content.ContentValues,%20java.lang.String,%20java.lang.String[],%20int)

  /// Verifies that a SQL `SELECT` statement is valid by compiling it.
  ///
  /// If the SQL statement is not valid, this method will throw a [SQLiteException].
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#validateSql(java.lang.String,%20android.os.CancellationSignal)
  Future<void> validateSql(final String sql) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'sql': sql};
    return _channel.invokeMethod('validateSql', request);
  }

  /// Temporarily end the transaction to let other threads run.
  ///
  /// The transaction is assumed to be successful so far. Do not call
  /// [setTransactionSuccessful] before calling this. When this returns a new
  /// transaction will have been created but not marked as successful. This
  /// assumes that there are no nested transactions ([beginTransaction] has only
  /// been called once) and will throw an exception if that is not the case.
  ///
  /// If `sleepAfterYieldDelay` > 0, sleep this long before starting a new
  /// transaction if the lock was actually yielded. This will allow other
  /// background threads to make some more progress than they would if we
  /// started the transaction immediately.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#yieldIfContendedSafely()
  Future<bool> yieldIfContendedSafely([final int sleepAfterYieldDelay = 0]) {
    final Map<String, dynamic> request = <String, dynamic>{'id': id, 'sleepAfterYieldDelay': sleepAfterYieldDelay};
    return _channel.invokeMethod('yieldIfContendedSafely', request) as Future<bool>;
  }
}

class _SQLiteDatabase extends SQLiteDatabase {
  final int _id;

  _SQLiteDatabase(final int id) : _id = id;

  @override
  int get id => _id;
}
