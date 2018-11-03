/* This is free and unencumbered software released into the public domain. */

import 'dart:async' show Future;

import 'package:flutter/services.dart' show MethodChannel;

/// Exposes results from a query on a [SQLiteDatabase].
///
/// [SQLiteCursor] is not internally synchronized so code using a [SQLiteCursor]
/// from multiple threads should perform its own synchronization when using the
/// [SQLiteCursor].
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteCursor
class SQLiteCursor {
  static const MethodChannel _channel = MethodChannel('flutter_sqlcipher/SQLiteCursor');

  /// Closes the cursor, releasing all of its resources and making it completely
  /// invalid.
  Future<void> close() {
    // TODO
  }
}
