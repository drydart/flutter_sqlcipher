/* This is free and unencumbered software released into the public domain. */

/// SQLite interface.
///
/// See: https://developer.android.com/reference/android/database/sqlite/package-summary
library sqlite;

import 'dart:async' show Future;

import 'package:flutter/services.dart' show MethodChannel;

export 'src/cursor.dart' show SQLiteCursor;
export 'src/database.dart' show SQLiteDatabase;
export 'src/exception.dart';

/// SQLite interface.
abstract class SQLite {
  static const MethodChannel _channel = MethodChannel('flutter_sqlcipher/SQLite');

  /// Executes `SELECT sqlite_version()`.
  static Future<String> get version async {
    return await _channel.invokeMethod('getVersion') as String;
  }
}
