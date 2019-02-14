/* This is free and unencumbered software released into the public domain. */

package com.github.drydart.flutter_sqlcipher;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;
import net.sqlcipher.database.SQLiteDatabase;

/** FlutterSQLCipherPlugin */
public class FlutterSQLCipherPlugin {

  /** Plugin registration. */
  public static void registerWith(final Registrar registrar) {
    assert(registrar != null);

    SQLiteDatabase.loadLibs(registrar.context());

    (new MethodChannel(registrar.messenger(), SQLCipherHandler.CHANNEL))
      .setMethodCallHandler(new SQLCipherHandler(registrar));

    (new MethodChannel(registrar.messenger(), SQLiteHandler.CHANNEL))
      .setMethodCallHandler(new SQLiteHandler(registrar));

    (new MethodChannel(registrar.messenger(), SQLiteDatabaseHandler.CHANNEL))
      .setMethodCallHandler(new SQLiteDatabaseHandler(registrar));

    (new MethodChannel(registrar.messenger(), SQLiteCursorHandler.CHANNEL))
      .setMethodCallHandler(new SQLiteCursorHandler(registrar));
  }
}
