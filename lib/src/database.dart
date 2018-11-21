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

  /// The internal database identifier.
  int get id;

  /// Create a memory backed SQLite database.
  ///
  /// Its contents will be destroyed when the database is closed.
  ///
  /// Throws an [SQLiteException] if the database cannot be created.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase.html#create(android.database.sqlite.SQLiteDatabase.CursorFactory)
  static Future<SQLiteDatabase> create({String password}) {
    return createInMemory(password: password);
  }

  /// Create a memory backed SQLite database.
  ///
  /// Its contents will be destroyed when the database is closed.
  ///
  /// Throws an [SQLiteException] if the database cannot be created.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase.html#createInMemory(android.database.sqlite.SQLiteDatabase.OpenParams)
  static Future<SQLiteDatabase> createInMemory({String password}) async {
    try {
      final Map<String, dynamic> args = <String, dynamic>{'password': password};
      final int id = await _channel.invokeMethod('createInMemory', args);
      return _SQLiteDatabase(id);
    }
    on PlatformException catch (error) {
      throw error; // TODO: error handling
    }
  }

  /// Deletes a database including its journal file and other auxiliary files
  /// that may have been created by the database engine.
  ///
  /// See: https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase.html#deleteDatabase(java.io.File)
  static Future<bool> deleteDatabase(final String path) {
    final Map<String, dynamic> args = <String, dynamic>{'path': path};
    return _channel.invokeMethod('deleteDatabase', args) as Future<bool>;
  }

  /// Open the database according to the specified parameters.
  ///
  /// @param path
  static Future<SQLiteDatabase> openDatabase(final String path) {
    return Future.value(null); // TODO
  }

  /// Equivalent to `openDatabase(path, CREATE_IF_NECESSARY)`.
  ///
  /// @param path
  static Future<SQLiteDatabase> openOrCreateDatabase(final String path) {
    return Future.value(null); // TODO
  }

  /// Gets the path to the database file.
  Future<String> get path {
    final Map<String, dynamic> args = <String, dynamic>{'id': id};
    return _channel.invokeMethod('getPath', args) as Future<String>;
  }

  /// Gets the database version.
  Future<int> get version {
    final Map<String, dynamic> args = <String, dynamic>{'id': id};
    return _channel.invokeMethod('getVersion', args) as Future<int>;
  }

  /// Returns true if the database is currently open.
  Future<bool> get isOpen {
    final Map<String, dynamic> args = <String, dynamic>{'id': id};
    return _channel.invokeMethod('isOpen', args) as Future<bool>;
  }

  /// Returns true if the database is opened as read only.
  Future<bool> get isReadOnly {
    final Map<String, dynamic> args = <String, dynamic>{'id': id};
    return _channel.invokeMethod('isReadOnly', args) as Future<bool>;
  }

  /// Sets the locale for this database.
  ///
  /// Does nothing if this database has the `NO_LOCALIZED_COLLATORS` flag set or
  /// was opened read only.
  Future<void> setLocale(final Locale locale) {
    return Future.value(null); // TODO
  }

  /// Runs the provided SQL and returns a cursor over the result set.
  ///
  /// @param sql
  Future<SQLiteCursor> rawQuery(final String sql) async {
    final Map<String, dynamic> args = <String, dynamic>{'id': id, 'sql': sql};
    final List<dynamic> result = await _channel.invokeMethod('rawQuery', args);
    assert(result.length == 2);
    final List<String> columns = (result[0] as List<dynamic>).cast<String>();
    final List<List<dynamic>> rows = (result[1] as List<dynamic>).cast<List<dynamic>>();
    return SQLiteCursor.from(columns: columns, rows: rows);
  }
}

class _SQLiteDatabase extends SQLiteDatabase {
  final int _id;

  _SQLiteDatabase(final int id) : _id = id;

  @override
  int get id => _id;
}
