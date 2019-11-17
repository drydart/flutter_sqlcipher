/* This is free and unencumbered software released into the public domain. */

package com.github.drydart.flutter_sqlcipher;

import android.content.ContentValues;
import android.database.Cursor;
import android.os.Parcel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import java.io.File;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import net.sqlcipher.database.SQLiteDatabase;

/** SQLiteDatabaseHandler */
@SuppressWarnings("unchecked")
class SQLiteDatabaseHandler extends FlutterMethodCallHandler {
  static final String CHANNEL = "flutter_sqlcipher/SQLiteDatabase";

  final Map<Integer, SQLiteDatabase> databases = new HashMap<>();
  int databaseID;

  SQLiteDatabaseHandler(final Registrar registrar) {
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
      /* Static methods */

      case "openDatabase": {
        final String path = getRequiredArgument(call, "path");
        final String password = getOptionalArgument(call, "password");
        final int flags = getRequiredArgument(call, "flags");
        databaseID += 1;
        final SQLiteDatabase db = SQLiteDatabase.openDatabase(path, password, null, flags);
        this.databases.put(databaseID, db);
        result.success(databaseID);
        break;
      }

      case "deleteDatabase": {
        final File path = new File((String)getRequiredArgument(call, "path"));
        result.success(android.database.sqlite.SQLiteDatabase.deleteDatabase(path));
        break;
      }

      case "releaseMemory": {
        result.success(SQLiteDatabase.releaseMemory());
        break;
      }

      /* Instance methods ("id" argument required) */

      case "beginTransaction": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String mode = getOptionalArgument(call, "mode", "exclusive");
        switch (mode) {
          case "exclusive":
            db.beginTransaction();
            break;
          case "immediate":
            db.beginTransactionNonExclusive();
            break;
          default:
            assert(false); // unreachable
            throw new AssertionError();
        }
        result.success(null);
        break;
      }

      case "close": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        db.close();
        result.success(null);
        break;
      }

      case "delete": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String table = getRequiredArgument(call, "table");
        final String whereClause = getOptionalArgument(call, "whereClause");
        final List<String> whereArgs = getOptionalArgument(call, "whereArgs");
        result.success(db.delete(table, whereClause,
          (whereArgs != null) ? whereArgs.toArray(new String[0]) : null));
        break;
      }

      case "disableWriteAheadLogging": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        db.disableWriteAheadLogging();
        result.success(null);
        break;
      }

      case "enableWriteAheadLogging": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.enableWriteAheadLogging());
        break;
      }

      case "endTransaction": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        db.endTransaction();
        result.success(null);
        break;
      }

      case "execSQL": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String sql = getRequiredArgument(call, "sql");
        final List<Object> args = getOptionalArgument(call, "args");
        db.execSQL(sql, (args != null) ? args.toArray() : null);
        result.success(null);
        break;
      }

      case "getAttachedDbs": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.getAttachedDbs()); // FIXME
        break;
      }

      case "getMaximumSize": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.getMaximumSize());
        break;
      }

      case "getPageSize": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.getPageSize());
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

      case "inTransaction": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.inTransaction());
        break;
      }

      case "insert": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String table = getRequiredArgument(call, "table");
        final Map<String, Object> values = getRequiredArgument(call, "values");
        result.success(db.insert(table, null, convertMapToContentValues(values)));
        break;
      }

      case "insertOrThrow": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String table = getRequiredArgument(call, "table");
        final Map<String, Object> values = getRequiredArgument(call, "values");
        result.success(db.insertOrThrow(table, null, convertMapToContentValues(values)));
        break;
      }

      case "insertWithOnConflict": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String table = getRequiredArgument(call, "table");
        final Map<String, Object> values = getRequiredArgument(call, "values");
        final int conflictAlgorithm = getRequiredArgument(call, "conflictAlgorithm");
        result.success(db.insertWithOnConflict(table, null, convertMapToContentValues(values), conflictAlgorithm));
        break;
      }

      case "isDatabaseIntegrityOk": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.isDatabaseIntegrityOk());
        break;
      }

      case "isDbLockedByCurrentThread": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.isDbLockedByCurrentThread());
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

      case "isWriteAheadLoggingEnabled": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        result.success(db.isWriteAheadLoggingEnabled());
        break;
      }

      case "needUpgrade": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final int newVersion = getRequiredArgument(call, "newVersion");
        result.success(db.needUpgrade(newVersion));
        break;
      }

      case "query": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final boolean distinct = getOptionalArgument(call, "distinct");
        final String table = getRequiredArgument(call, "table");
        final List<String> columns = getOptionalArgument(call, "columns");
        final String selection = getOptionalArgument(call, "selection");
        final List<String> selectionArgs = getOptionalArgument(call, "selectionArgs");
        final String groupBy = getOptionalArgument(call, "groupBy");
        final String having = getOptionalArgument(call, "having");
        final String orderBy = getOptionalArgument(call, "orderBy");
        final String limit = getOptionalArgument(call, "limit");
        final Cursor cursor = db.query(distinct,
          table,
          (columns != null) ? columns.toArray(new String[0]) : null,
          selection,
          (selectionArgs != null) ? selectionArgs.toArray(new String[0]) : null,
          groupBy,
          having,
          orderBy,
          limit
        );
        try {
          result.success(serializeCursor(cursor));
        }
        finally {
          cursor.close();
        }
        break;
      }

      case "rawQuery": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String sql = getRequiredArgument(call, "sql");
        final List<String> args = getOptionalArgument(call, "args");
        final Cursor cursor = db.rawQuery(sql, (args != null) ? args.toArray(new String[0]) : new String[0]);
        try {
          result.success(serializeCursor(cursor));
        }
        finally {
          cursor.close();
        }
        break;
      }

      case "replace": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String table = getRequiredArgument(call, "table");
        final Map<String, Object> values = getRequiredArgument(call, "values");
        result.success(db.replace(table, null, convertMapToContentValues(values)));
        break;
      }

      case "replaceOrThrow": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String table = getRequiredArgument(call, "table");
        final Map<String, Object> values = getRequiredArgument(call, "values");
        result.success(db.replaceOrThrow(table, null, convertMapToContentValues(values)));
        break;
      }

      case "setForeignKeyConstraintsEnabled": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final boolean enable = getRequiredArgument(call, "enable");
        db.setForeignKeyConstraintsEnabled(enable);
        result.success(null);
        break;
      }

      case "setLocale": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String localeTag = getRequiredArgument(call, "locale");
        final Locale locale = Locale.forLanguageTag(localeTag.replace('_', '-'));
        db.setLocale(locale);
        result.success(null);
        break;
      }

      case "setMaxSqlCacheSize": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final int cacheSize = getRequiredArgument(call, "cacheSize");
        db.setMaxSqlCacheSize(cacheSize);
        result.success(null);
        break;
      }

      case "setMaximumSize": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final long numBytes = getRequiredArgument(call, "numBytes");
        db.setMaximumSize(numBytes);
        result.success(null);
        break;
      }

      case "setPageSize": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final long numBytes = getRequiredArgument(call, "numBytes");
        db.setPageSize(numBytes);
        result.success(null);
        break;
      }

      case "setTransactionSuccessful": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        db.setTransactionSuccessful();
        result.success(null);
        break;
      }

      case "setVersion": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final int version = getRequiredArgument(call, "version");
        db.setVersion(version);
        result.success(null);
        break;
      }

      case "update": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String table = getRequiredArgument(call, "table");
        final Map<String, Object> values = getRequiredArgument(call, "values");
        final String whereClause = getOptionalArgument(call, "whereClause");
        final List<String> whereArgs = getOptionalArgument(call, "whereArgs");
        result.success(db.update(table, convertMapToContentValues(values), whereClause,
          (whereArgs != null) ? whereArgs.toArray(new String[0]) : null));
        break;
      }

      case "updateWithOnConflict": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String table = getRequiredArgument(call, "table");
        final Map<String, Object> values = getRequiredArgument(call, "values");
        final String whereClause = getOptionalArgument(call, "whereClause");
        final List<String> whereArgs = getOptionalArgument(call, "whereArgs");
        final int conflictAlgorithm = getRequiredArgument(call, "conflictAlgorithm");
        result.success(db.updateWithOnConflict(table, convertMapToContentValues(values), whereClause,
          (whereArgs != null) ? whereArgs.toArray(new String[0]) : null, conflictAlgorithm));
        break;
      }

      case "validateSql": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final String sql = getRequiredArgument(call, "sql");
        //db.validateSql(sql); // TODO: this is missing in SQLCipher 4.0.0
        result.success(null);
        break;
      }

      case "yieldIfContendedSafely": {
        final SQLiteDatabase db = this.getDatabaseArgument(call);
        final long sleepAfterYieldDelay = getRequiredArgument(call, "sleepAfterYieldDelay");
        result.success(db.yieldIfContendedSafely(sleepAfterYieldDelay));
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
    assert(cursor.isBeforeFirst());

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

    final int id = getRequiredArgument(call, "id");
    if (!this.databases.containsKey(id)) {
      throw new AssertionError();
    }
    return this.databases.get(id);
  }

  private static ContentValues
  convertMapToContentValues(final Map<String, Object> input) {
    assert(input != null);

    ContentValues cv = new ContentValues(input.size());
    for (final Map.Entry<String,Object> entry : input.entrySet()) {
      final String key = entry.getKey();
      final Object value = entry.getValue();

      if (value == null) {
        cv.putNull(key);
      }
      else if (value instanceof Boolean) {
        cv.put(key, (Boolean)value);
      }
      else if (value instanceof Byte) {
        cv.put(key, (Byte)value);
      }
      else if (value instanceof Short) {
        cv.put(key, (Short)value);
      }
      else if (value instanceof Integer) {
        cv.put(key, (Integer)value);
      }
      else if (value instanceof Long) {
        cv.put(key, (Long)value);
      }
      else if (value instanceof Double) {
        cv.put(key, (Double)value);
      }
      else if (value instanceof Float) {
        cv.put(key, (Float)value);
      }
      else if (value instanceof String) {
        cv.put(key, (String)value);
      }
      else if (value instanceof byte[]) {
        cv.put(key, (byte[])value);
      }
      else {
        throw new IllegalArgumentException("Unsupported class type " + value.getClass() + " for key " + key);
      }
    }
    return cv;
  }
}
