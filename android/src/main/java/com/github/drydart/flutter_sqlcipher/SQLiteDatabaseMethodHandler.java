/* This is free and unencumbered software released into the public domain. */

package com.github.drydart.flutter_sqlcipher;

import android.database.Cursor;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.io.File;
import java.util.HashMap;
import java.util.Map;
import net.sqlcipher.database.SQLiteDatabase;

/** SQLiteDatabaseMethodHandler */
class SQLiteDatabaseMethodHandler implements MethodCallHandler {
  static final String CHANNEL = "flutter_sqlcipher/SQLiteDatabase";

  final Registrar registrar;
  final Map<Integer, SQLiteDatabase> databases = new HashMap<>();

  SQLiteDatabaseMethodHandler(final Registrar registrar) {
    this.registrar = registrar;
  }

  @Override
  public void onMethodCall(final MethodCall call, final Result result) {
    assert(call != null);
    assert(result != null);

    assert(call.method != null);
    switch (call.method) {
      case "deleteDatabase": {
        final File path = new File((String)call.argument("path"));
        result.success(android.database.sqlite.SQLiteDatabase.deleteDatabase(path));
        break;
      }
      default: {
        result.notImplemented();
      }
    }
  }
}
