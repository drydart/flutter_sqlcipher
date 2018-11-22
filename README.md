SQLCipher Database for Flutter
==============================

[![Project license](https://img.shields.io/badge/license-Public%20Domain-blue.svg)](https://unlicense.org)
[![Pub package](https://img.shields.io/pub/v/flutter_sqlcipher.svg)](https://pub.dartlang.org/packages/flutter_sqlcipher)
[![Dartdoc reference](https://img.shields.io/badge/dartdoc-reference-blue.svg)](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/)
[![Travis CI build status](https://img.shields.io/travis/drydart/flutter_sqlcipher/master.svg)](https://travis-ci.org/drydart/flutter_sqlcipher)

Compatibility
-------------

Android only, at present.

Example
-------

```dart
import 'package:flutter_sqlcipher/sqlite.dart';
import 'package:flutter_android/android_database.dart' show DatabaseUtils;

var db = await SQLiteDatabase.createInMemory();

var cursor = await db.rawQuery("SELECT 1 AS a, 2 as b, 3 AS c", []);

await DatabaseUtils.dumpCursor(cursor);
```

Reference
---------

### [`sqlite`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/sqlite-library.html)

    import 'package:flutter_sqlcipher/sqlite.dart';

- [`SQLite.version`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLite/version.html)
- [`SQLiteCursor`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteCursor-class.html)
- [`SQLiteDatabase`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase-class.html)
- [`SQLiteDatabase.create()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/create.html)
- [`SQLiteDatabase.createInMemory()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/createInMemory.html)
- [`SQLiteDatabase.deleteDatabase()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/deleteDatabase.html)
- [`SQLiteDatabase.openDatabase()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/openDatabase.html)
- [`SQLiteDatabase.openOrCreateDatabase()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/openOrCreateDatabase.html)
- [`SQLiteDatabase#execSQL()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/execSQL.html)
- [`SQLiteDatabase#path`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/path.html)
- [`SQLiteDatabase#version`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/version.html)
- [`SQLiteDatabase#isOpen`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/isOpen.html)
- [`SQLiteDatabase#isReadOnly`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/isReadOnly.html)
- [`SQLiteDatabase#isWriteAheadLoggingEnabled`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/isWriteAheadLoggingEnabled.html)
- [`SQLiteDatabase#rawQuery()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/rawQuery.html)
- [`SQLiteDatabase#setLocale()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/setLocale.html)

### [`sqlcipher`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlcipher/sqlcipher-library.html)

    import 'package:flutter_sqlcipher/sqlcipher.dart';

- [`SQLCipher.version`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlcipher/SQLCipher/version.html)
