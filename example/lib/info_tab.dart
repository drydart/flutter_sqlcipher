/* This is free and unencumbered software released into the public domain. */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_sqlcipher/sqlcipher.dart';
import 'package:flutter_sqlcipher/sqlite.dart';

////////////////////////////////////////////////////////////////////////////////

class InfoTab extends StatefulWidget {
  @override
  State<InfoTab> createState() => _InfoState();
}

////////////////////////////////////////////////////////////////////////////////

class _InfoState extends State<InfoTab> {
  String _sqlcipherVersion = "Unknown";
  String _sqliteVersion = "Unknown";

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  @override
  Widget build(final BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("SQLCipher $_sqlcipherVersion\n"),
          Text("SQLite $_sqliteVersion\n"),
        ],
      ),
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    String sqlcipherVersion, sqliteVersion;
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      sqlcipherVersion = await SQLCipher.version;
      sqliteVersion = await SQLite.version;
    }
    on PlatformException {
      sqlcipherVersion = "Failed to get SQLCipher library version.";
      sqliteVersion = "Failed to get SQLite library version.";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() {
      _sqlcipherVersion = sqlcipherVersion;
      _sqliteVersion = sqliteVersion;
    });
  }
}
