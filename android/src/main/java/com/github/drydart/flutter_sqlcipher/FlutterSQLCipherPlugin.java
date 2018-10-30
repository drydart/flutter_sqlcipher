/* This is free and unencumbered software released into the public domain. */

package com.github.drydart.flutter_sqlcipher;

import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.PluginRegistry.Registrar;

/** FlutterSQLCipherPlugin */
public class FlutterSQLCipherPlugin {

  /** Plugin registration. */
  public static void registerWith(final Registrar registrar) {
    assert(registrar != null);

    (new MethodChannel(registrar.messenger(), SQLCipherMethodHandler.CHANNEL))
      .setMethodCallHandler(new SQLCipherMethodHandler());

    (new MethodChannel(registrar.messenger(), SQLiteMethodHandler.CHANNEL))
      .setMethodCallHandler(new SQLiteMethodHandler());

    (new MethodChannel(registrar.messenger(), SQLiteDatabaseMethodHandler.CHANNEL))
      .setMethodCallHandler(new SQLiteDatabaseMethodHandler());

    (new MethodChannel(registrar.messenger(), SQLiteCursorMethodHandler.CHANNEL))
      .setMethodCallHandler(new SQLiteCursorMethodHandler());
  }
}
