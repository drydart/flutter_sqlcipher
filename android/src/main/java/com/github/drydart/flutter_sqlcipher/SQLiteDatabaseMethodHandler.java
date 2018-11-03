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
  int databaseID;

  SQLiteDatabaseMethodHandler(final Registrar registrar) {
    this.registrar = registrar;
  }

  @Override
  public void onMethodCall(final MethodCall call, final Result result) {
    assert(call != null);
    assert(result != null);

    assert(call.method != null);
    switch (call.method) {
      case "createInMemory": {
        final String password = call.argument("password");
        final SQLiteDatabase db = SQLiteDatabase.openOrCreateDatabase(":memory:", password, null);
        databaseID += 1;
        this.databases.put(databaseID, db);
        result.success(databaseID);
        break;
      }
      case "deleteDatabase": {
        final File path = new File((String)call.argument("path"));
        result.success(android.database.sqlite.SQLiteDatabase.deleteDatabase(path));
        break;
      }
      case "getPath": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.getPath().toString());
        break;
      }
      case "getVersion": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.getVersion());
        break;
      }
      case "isOpen": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.isOpen());
        break;
      }
      case "isReadOnly": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.isReadOnly());
        break;
      }
      default: {
        result.notImplemented();
      }
    }
  }

  SQLiteDatabase getDatabaseArgument(final MethodCall call) {
    if (!call.hasArgument("id")) throw new AssertionError();
    final int id = call.argument("id");
    if (!this.databases.containsKey(id)) throw new AssertionError();
    return this.databases.get(id);
  }
}
