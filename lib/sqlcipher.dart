/* This is free and unencumbered software released into the public domain. */

library sqlcipher;

import 'dart:async';

import 'package:flutter/services.dart';

/// TODO
abstract class SQLCipher {
  static const MethodChannel _channel = const MethodChannel('flutter_sqlcipher/SQLCipher');

  /// Executes `PRAGMA cipher_version`.
  static Future<String> get version async {
    final String version = await _channel.invokeMethod('getVersion');
    return version;
  }
}
