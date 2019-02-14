/* This is free and unencumbered software released into the public domain. */

package com.github.drydart.flutter_sqlcipher;

import android.database.Cursor;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import net.sqlcipher.database.SQLiteCursor;

/** SQLiteCursorHandler */
class SQLiteCursorHandler extends FlutterMethodCallHandler {
  static final String CHANNEL = "flutter_sqlcipher/SQLiteCursor";

  SQLiteCursorHandler(final Registrar registrar) {
    super(registrar);
  }

  @Override
  public void
  onMethodCall(final MethodCall call,
               final Result result) {
    assert(call != null);
    assert(result != null);

    assert(call.method != null);
    switch (call.method) {
      default: {
        result.notImplemented();
      }
    }
  }
}
