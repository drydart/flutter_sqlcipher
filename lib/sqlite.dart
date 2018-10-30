/* This is free and unencumbered software released into the public domain. */

library sqlite;

import 'dart:async';

import 'package:flutter/services.dart';

export 'src/cursor.dart' show SQLiteCursor;
export 'src/database.dart' show SQLiteDatabase;
export 'src/exception.dart';

/// TODO
abstract class SQLite {
  static const MethodChannel _channel = const MethodChannel('flutter_sqlcipher/SQLite');

  /// Executes `SELECT sqlite_version()`.
  static Future<String> get version async {
    final String version = await _channel.invokeMethod('getVersion');
    return version;
  }
}
