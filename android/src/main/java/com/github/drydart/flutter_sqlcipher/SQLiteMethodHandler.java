/* This is free and unencumbered software released into the public domain. */

package com.github.drydart.flutter_sqlcipher;

import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

import net.sqlcipher.database.SQLiteDatabase;

/** SQLiteMethodHandler */
class SQLiteMethodHandler implements MethodCallHandler {
  static final String CHANNEL = "flutter_sqlcipher/SQLite";

  @Override
  public void onMethodCall(final MethodCall call, final Result result) {
    assert(call != null);
    assert(result != null);

    if (call.method.equals("getVersion")) {
      result.success("Android " + android.os.Build.VERSION.RELEASE); // TODO
      return;
    }

    result.notImplemented();
  }
}
