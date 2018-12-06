/* This is free and unencumbered software released into the public domain. */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_sqlcipher/sqlcipher.dart';
import 'package:flutter_sqlcipher/sqlite.dart';

////////////////////////////////////////////////////////////////////////////////

class Info {
  String sqlcipherVersion;
  String sqliteVersion;
  int pageSize;
  int maximumSize;

  Info({this.sqlcipherVersion, this.sqliteVersion, this.pageSize, this.maximumSize});
}

////////////////////////////////////////////////////////////////////////////////

class InfoTab extends StatefulWidget {
  @override
  State<InfoTab> createState() => _InfoState();
}

////////////////////////////////////////////////////////////////////////////////

class _InfoState extends State<InfoTab> {
  Info _info = Info();

  @override
  void initState() {
    super.initState();
    _initPlatformState();
  }

  @override
  Widget build(final BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(8.0),
      itemCount: 4,
      itemBuilder: (final BuildContext context, final int index) {
        switch (index) {
          case 0:
            return ListTile(
              leading: Icon(Icons.new_releases),
              title: Text("SQLCipher"),
              subtitle: Text(_info.sqlcipherVersion ?? "Unknown"),
              //trailing: Icon(Icons.info, color: Theme.of(context).disabledColor),
            );
          case 1:
            return ListTile(
              leading: Icon(Icons.new_releases),
              title: Text("SQLite"),
              subtitle: Text(_info.sqliteVersion ?? "Unknown"),
            );
          case 2:
            return ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Page size"),
              subtitle: Text(_info.pageSize != null ? _info.pageSize.toString() : "Unknown"), // TODO: format the number
            );
          case 3:
            return ListTile(
              leading: Icon(Icons.info_outline),
              title: Text("Maximum size"),
              subtitle: Text(_info.maximumSize != null ? _info.maximumSize.toString() : "Unknown"), // TODO: format the number
            );
          default:
            assert(false); // unreachable
            return null;
        }
      },
      separatorBuilder: (final BuildContext context, final int index) {
        return Divider();
      },
    );
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> _initPlatformState() async {
    Info info = Info();
    // Platform messages may fail, so we use a try/catch PlatformException.
    try {
      info.sqlcipherVersion = await SQLCipher.version;
      info.sqliteVersion = await SQLite.version;
      final SQLiteDatabase db = await SQLiteDatabase.createInMemory();
      info.pageSize = await db.getPageSize();
      info.maximumSize = await db.getMaximumSize();
    }
    on PlatformException {
      // TODO: improve error handling
      info.sqlcipherVersion = "Failed to get SQLCipher library version.";
      info.sqliteVersion = "Failed to get SQLite library version.";
    }

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;

    setState(() { _info = info; });
  }
}
