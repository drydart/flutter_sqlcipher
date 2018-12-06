/* This is free and unencumbered software released into the public domain. */

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show PlatformException;
import 'package:flutter_android/android_database.dart' show DatabaseUtils;
import 'package:flutter_sqlcipher/sqlite.dart';

////////////////////////////////////////////////////////////////////////////////

class QueryTab extends StatefulWidget {
  @override
  State<QueryTab> createState() => _QueryState();
}

////////////////////////////////////////////////////////////////////////////////

class _QueryState extends State<QueryTab> {
  final String _query = "SELECT ? AS a, ? as b, ? AS c";
  String _result = "Unknown";

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
          Text(_query),
          Text(_result),
        ],
      ),
    );
  }

  Future<void> _initPlatformState() async {
    String result;
    try {
      final SQLiteDatabase db = await SQLiteDatabase.createInMemory();
      try {
        final SQLiteCursor cursor = await db.rawQuery(_query, ['11', '22', '33']);
        try {
          result = await DatabaseUtils.dumpCursorToString(cursor);
        }
        finally {
          cursor.close();
        }
      }
      finally {
        db.close();
      }
    }
    on PlatformException {
      result = "Failed to dump cursor.";
    }

    if (!mounted) return;

    setState(() {
      _result = result;
    });
  }
}
