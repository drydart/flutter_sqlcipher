/* This is free and unencumbered software released into the public domain. */

package com.github.drydart.flutter_sqlcipher;

import android.database.Cursor;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import net.sqlcipher.database.SQLiteDatabase;

/** SQLiteMethodHandler */
class SQLiteMethodHandler implements MethodCallHandler {
  static final String CHANNEL = "flutter_sqlcipher/SQLite";

  final Registrar registrar;

  SQLiteMethodHandler(final Registrar registrar) {
    this.registrar = registrar;
  }

  @Override
  public void
  onMethodCall(final MethodCall call,
               final Result result) {
    assert(call != null);
    assert(result != null);

    assert(call.method != null);
    switch (call.method) {

      case "getVersion": {
        final SQLiteDatabase db = SQLiteDatabase.openOrCreateDatabase(":memory:", (String)null, null);
        final Cursor cursor = db.rawQuery("SELECT sqlite_version()", null);
        cursor.moveToNext();
        result.success(cursor.getString(0));
        break;
      }

      default: {
        result.notImplemented();
      }
    }
  }
}
