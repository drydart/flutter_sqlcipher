/* This is free and unencumbered software released into the public domain. */

import 'dart:async' show Future;
import 'dart:ui' show Locale;

import 'package:flutter/services.dart' show MethodChannel;

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
class SQLiteDatabase {
  static const MethodChannel _channel = const MethodChannel('flutter_sqlcipher/SQLiteDatabase');

  /// Create a memory backed SQLite database.
  ///
  /// Its contents will be destroyed when the database is closed.
  static Future<SQLiteDatabase> create() {
    return Future.value(null); // TODO
  }

  /// Create a memory backed SQLite database.
  ///
  /// Its contents will be destroyed when the database is closed.
  static Future<SQLiteDatabase> createInMemory() {
    return Future.value(null); // TODO
  }

  /// Deletes a database including its journal file and other auxiliary files
  /// that may have been created by the database engine.
  ///
  /// @param path
  static Future<bool> deleteDatabase(final String path) {
    return Future.value(false); // TODO
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
  String get path => null; // TODO

  /// Gets the database version.
  Future<int> get version => null; // TODO

  /// Returns true if the database is currently open.
  bool get isOpen => null; // TODO

  /// Returns true if the database is opened as read only.
  bool get isReadOnly => null; // TODO

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
  SQLiteCursor rawQuery(final String sql) {
    return null; // TODO
  }
}
