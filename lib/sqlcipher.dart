/* This is free and unencumbered software released into the public domain. */

/// SQLCipher interface.
///
/// See: https://www.zetetic.net/sqlcipher/sqlcipher-for-android/
///
/// See: https://github.com/sqlcipher/android-database-sqlcipher
library sqlcipher;

import 'dart:async' show Future;

import 'package:flutter/services.dart' show MethodChannel;

/// SQLCipher interface.
abstract class SQLCipher {
  static const MethodChannel _channel = MethodChannel('flutter_sqlcipher/SQLCipher');

  /// Executes `PRAGMA cipher_version`.
  static Future<String> get version async {
    return await _channel.invokeMethod('getVersion') as String;
  }
}
