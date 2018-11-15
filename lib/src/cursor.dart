/* This is free and unencumbered software released into the public domain. */

import 'dart:async' show Future;
import 'dart:typed_data' show ByteBuffer;

import 'package:flutter/services.dart' show MethodChannel;
import 'package:flutter_android/android_database.dart' show Cursor;

/// Exposes results from a query on a [SQLiteDatabase].
///
/// [SQLiteCursor] is not internally synchronized so code using a [SQLiteCursor]
/// from multiple threads should perform its own synchronization when using the
/// [SQLiteCursor].
///
/// See: https://developer.android.com/reference/android/database/sqlite/SQLiteCursor
class SQLiteCursor extends Cursor {
  static const MethodChannel _channel = MethodChannel('flutter_sqlcipher/SQLiteCursor');

  bool _isClosed = false;

  @override
  Future<void> close() {
    _isClosed = true;
    return Future.value();
  }

  @override
  ByteBuffer getBlob(final int columnIndex) => null; // TODO

  @override
  List<String> getColumnNames() => <String>[]; // TODO

  @override
  int getCount() => 0; // TODO

  @override
  double getDouble(final int columnIndex) => null; // TODO

  @override
  int getInt(final int columnIndex) => null; // TODO

  @override
  int getPosition() => -1; // TODO

  @override
  String getString(final int columnIndex) => null; // TODO

  @override
  int getType(final int columnIndex) => null; // TODO

  @override
  bool get isClosed => _isClosed; // TODO

  @override
  bool isNull(final int columnIndex) => null; // TODO

  @override
  bool moveToPosition(final int position) => false; // TODO
}
