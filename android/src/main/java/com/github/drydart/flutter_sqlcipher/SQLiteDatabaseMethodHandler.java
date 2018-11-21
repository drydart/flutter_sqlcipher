/* This is free and unencumbered software released into the public domain. */

package com.github.drydart.flutter_sqlcipher;

import android.database.Cursor;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
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
  public void
  onMethodCall(final MethodCall call,
               final Result result) {
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

      case "rawQuery": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String sql = getArgument(call, "sql");
        final Cursor cursor = db.rawQuery(sql, null);
        try {
          result.success(serializeCursor(cursor));
        }
        finally {
          cursor.close();
        }
        break;
      }

      default: {
        result.notImplemented();
      }
    }
  }

  private List
  serializeCursor(final Cursor cursor) {
    assert(cursor != null);
    assert(!cursor.isClosed());

    final List<String> columns = Arrays.asList(cursor.getColumnNames());

    final List<List<Object>> rows = new ArrayList(cursor.getCount());
    while (cursor.moveToNext()) {
      final int columnCount = cursor.getColumnCount();
      final List<Object> row = new ArrayList(columnCount);
      for (int columnIndex = 0; columnIndex < columnCount; columnIndex++) {
        row.add(serializeColumnValue(cursor, columnIndex));
      }
      rows.add(row);
    }

    return Arrays.asList(columns, rows);
  }

  private Object
  serializeColumnValue(final Cursor cursor, final int columnIndex) {
    assert(cursor != null);
    assert(columnIndex >= 0);

    switch (cursor.getType(columnIndex)) {
      case Cursor.FIELD_TYPE_NULL:
        return null;
      case Cursor.FIELD_TYPE_INTEGER:
        return cursor.getLong(columnIndex);
      case Cursor.FIELD_TYPE_FLOAT:
        return cursor.getDouble(columnIndex);
      case Cursor.FIELD_TYPE_STRING:
        return cursor.getString(columnIndex);
      case Cursor.FIELD_TYPE_BLOB:
        return cursor.getBlob(columnIndex);
      default:
        assert(false); // unreachable
        throw new AssertionError();
    }
  }

  private SQLiteDatabase
  getDatabaseArgument(final MethodCall call) {
    assert(call != null);

    final int id = getArgument(call, "id");
    if (!this.databases.containsKey(id)) {
      throw new AssertionError();
    }
    return this.databases.get(id);
  }

  private static <T> T
  getArgument(final MethodCall call,
              final String name) {
    assert(call != null);
    assert(name != null);

    if (!call.hasArgument(name)) {
      throw new AssertionError();
    }
    return call.argument(name);
  }
}
