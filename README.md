SQLCipher Database for Flutter
==============================

[![Project license](https://img.shields.io/badge/license-Public%20Domain-blue.svg)](https://unlicense.org)
[![Pub package](https://img.shields.io/pub/v/flutter_sqlcipher.svg)](https://pub.dartlang.org/packages/flutter_sqlcipher)
[![Dartdoc reference](https://img.shields.io/badge/dartdoc-reference-blue.svg)](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/)
[![Travis CI build status](https://img.shields.io/travis/drydart/flutter_sqlcipher/master.svg)](https://travis-ci.org/drydart/flutter_sqlcipher)

This is a [Flutter](https://flutter.io/) plugin that bundles and wraps
[SQLCipher for Android](https://www.zetetic.net/sqlcipher/sqlcipher-for-android/),
an open-source extension to [SQLite](https://www.sqlite.org) that provides
transparent 256-bit [AES encryption](https://en.wikipedia.org/wiki/Advanced_Encryption_Standard)
of database files.

Features
--------

- Implements fully-encrypted SQLite databases stored on disk or in memory.

- Provides a high-fidelity subset of the
  [`android.database.sqlite`](https://developer.android.com/reference/android/database/sqlite/package-summary)
  API to aid Android developers migrating to Flutter.

- Supports booleans, doubles, integers, strings, blobs, and timestamps.

Compatibility
-------------

Android only, at present. (iOS support is planned.)

Examples
--------

### Querying an in-memory database

This example also uses
[`DatabaseUtils`](https://pub.dartlang.org/documentation/flutter_android/latest/android_database/DatabaseUtils-class.html)
from the [flutter_android](https://pub.dartlang.org/packages/flutter_android) package.

```dart
import 'package:flutter_sqlcipher/sqlite.dart';
import 'package:flutter_android/android_database.dart' show DatabaseUtils;

var db = await SQLiteDatabase.createInMemory();

var cursor = await db.rawQuery("SELECT 1 AS a, 2 as b, 3 AS c");

await DatabaseUtils.dumpCursor(cursor);
```

Frequently Asked Questions
--------------------------

### Which releases of SQLite and SQLCipher does this plugin bundle?

[SQLCipher for Android 4.0.0](https://search.maven.org/artifact/net.zetetic/android-database-sqlcipher/4.0.0/aar),
[SQLCipher 4.0.0](https://www.zetetic.net/blog/2018/11/30/sqlcipher-400-release/), and
[SQLite 3.25.2](https://www.sqlite.org/releaselog/3_25_2.html).

### Why this plugin instead of wrapping Android's native SQLite support?

Two good reasons are:

1. **Encryption**.
   Android's native SQLite support does not feature database encryption.
   By using this plugin, you can trivially enable encryption for your app
   database, something likely appreciated by both you as well as your users.

2. **Compatibility**.
   Android's native SQLite version
   [varies](https://developer.android.com/reference/android/database/sqlite/package-summary)
   greatly depending on the specific Android release, from SQLite 3.4
   (released in 2007) to SQLite 3.19 (released in 2017, bundled in
   Android 8.1). Further, some device manufacturers include different
   versions of SQLite on their devices. By using this plugin, you gain a
   consistent, predictable, and up-to-date version of SQLite for your app
   regardless of the Android release your app runs on.

### How much does using this plugin increase my final app size?

Due to the bundled SQLCipher native libraries, your final APK size currently
increases by about 6.7 MiB. We are actively
[investigating](https://github.com/drydart/flutter_sqlcipher/issues/2)
ways to reduce that footprint. (e.g.,
[pruning `.so` files](https://github.com/sqlcipher/android-database-sqlcipher/issues/362)
and [using ProGuard](https://github.com/sqlcipher/android-database-sqlcipher/pull/399)).

### Some of the `android.database.sqlite` API methods are missing?

We don't generally implement methods deprecated in the current Android API
level. For example, the
[`SQLiteDatabase#isDbLockedByOtherThreads()`](https://developer.android.com/reference/android/database/sqlite/SQLiteDatabase#isDbLockedByOtherThreads())
method was deprecated long ago (in Android 4.1), so we have omitted it from
the Dart interface when implementing this plugin.

Caveats
-------

- **At present, iOS is not supported.**
  This may eventually be
  [addressed](https://github.com/drydart/flutter_sqlcipher/issues/1)
  going forward by bundling and wrapping
  [FMDB](https://github.com/ccgus/fmdb) which includes SQLCipher support.

- **At present, cursors are fully materialized.**
  This means that queries which return very large result sets will incur
  nontrivial overhead in the IPC transfer of the cursor data from Java to
  Dart. We are planning on adding windowed cursor and streaming support in a
  future major release. In the meanwhile, `OFFSET` and `LIMIT` are your
  friends.

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
- [`SQLiteDatabase.releaseMemory()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/releaseMemory.html)
- [`SQLiteDatabase#inTransaction`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/inTransaction.html)
- [`SQLiteDatabase#maximumSize`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/maximumSize.html)
- [`SQLiteDatabase#pageSize`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/pageSize.html)
- [`SQLiteDatabase#path`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/path.html)
- [`SQLiteDatabase#version`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/version.html)
- [`SQLiteDatabase#beginTransaction()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/beginTransaction.html)
- [`SQLiteDatabase#beginTransactionNonExclusive()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/beginTransactionNonExclusive.html)
- [`SQLiteDatabase#close()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/close.html)
- [`SQLiteDatabase#delete()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/delete.html)
- [`SQLiteDatabase#disableWriteAheadLogging()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/disableWriteAheadLogging.html)
- [`SQLiteDatabase#enableWriteAheadLogging()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/enableWriteAheadLogging.html)
- [`SQLiteDatabase#endTransaction()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/endTransaction.html)
- [`SQLiteDatabase#execSQL()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/execSQL.html)
- [`SQLiteDatabase#getAttachedDbs()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/getAttachedDbs.html)
- [`SQLiteDatabase#getMaximumSize()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/getMaximumSize.html)
- [`SQLiteDatabase#getPageSize()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/getPageSize.html)
- [`SQLiteDatabase#getPath()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/getPath.html)
- [`SQLiteDatabase#getVersion()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/getVersion.html)
- [`SQLiteDatabase#insert()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/insert.html)
- [`SQLiteDatabase#insertOrThrow()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/insertOrThrow.html)
- [`SQLiteDatabase#insertWithOnConflict()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/insertWithOnConflict.html)
- [`SQLiteDatabase#isDatabaseIntegrityOk`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/isDatabaseIntegrityOk.html)
- [`SQLiteDatabase#isDbLockedByCurrentThread`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/isDbLockedByCurrentThread.html)
- [`SQLiteDatabase#isOpen`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/isOpen.html)
- [`SQLiteDatabase#isReadOnly`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/isReadOnly.html)
- [`SQLiteDatabase#isWriteAheadLoggingEnabled`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/isWriteAheadLoggingEnabled.html)
- [`SQLiteDatabase#needUpgrade()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/needUpgrade.html)
- [`SQLiteDatabase#query()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/query.html)
- [`SQLiteDatabase#rawQuery()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/rawQuery.html)
- [`SQLiteDatabase#replace()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/replace.html)
- [`SQLiteDatabase#replaceOrThrow()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/replaceOrThrow.html)
- [`SQLiteDatabase#setForeignKeyConstraintsEnabled()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/setForeignKeyConstraintsEnabled.html)
- [`SQLiteDatabase#setLocale()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/setLocale.html)
- [`SQLiteDatabase#setMaxSqlCacheSize()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/setMaxSqlCacheSize.html)
- [`SQLiteDatabase#setMaximumSize()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/setMaximumSize.html)
- [`SQLiteDatabase#setPageSize()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/setPageSize.html)
- [`SQLiteDatabase#setTransactionSuccessful()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/setTransactionSuccessful.html)
- [`SQLiteDatabase#setVersion()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/setVersion.html)
- [`SQLiteDatabase#update()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/update.html)
- [`SQLiteDatabase#updateWithOnConflict()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/updateWithOnConflict.html)
- [`SQLiteDatabase#validateSql()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/validateSql.html)
- [`SQLiteDatabase#yieldIfContendedSafely()`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlite/SQLiteDatabase/yieldIfContendedSafely.html)

### [`sqlcipher`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlcipher/sqlcipher-library.html)

    import 'package:flutter_sqlcipher/sqlcipher.dart';

- [`SQLCipher.version`](https://pub.dartlang.org/documentation/flutter_sqlcipher/latest/sqlcipher/SQLCipher/version.html)

See Also
--------

- The [sql_builder](https://pub.dartlang.org/packages/sql_builder) package
  that implements a fluent interface for constructing SQL queries.
