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

    (new MethodChannel(registrar.messenger(), SQLCipherMethodHandler.CHANNEL))
      .setMethodCallHandler(new SQLCipherMethodHandler(registrar));

    (new MethodChannel(registrar.messenger(), SQLiteMethodHandler.CHANNEL))
      .setMethodCallHandler(new SQLiteMethodHandler(registrar));

    (new MethodChannel(registrar.messenger(), SQLiteDatabaseMethodHandler.CHANNEL))
      .setMethodCallHandler(new SQLiteDatabaseMethodHandler(registrar));

    (new MethodChannel(registrar.messenger(), SQLiteCursorMethodHandler.CHANNEL))
      .setMethodCallHandler(new SQLiteCursorMethodHandler(registrar));
  }
}
