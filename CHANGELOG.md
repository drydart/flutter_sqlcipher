Changelog
---------

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [0.4.0] - 2019-02-14
### Changed
- Require Dart SDK 2.1+

## [0.3.5] - 2019-01-26
### Changed
- Added more examples to the README.

## [0.3.4] - 2019-01-26
### Changed
- Fixed a type error in `SQLiteDatabase#insertOrThrow()`
- Fixed a type error in `SQLiteDatabase#replaceOrThrow()`
- Fixed a type error in `SQLiteDatabase#update()`
- Fixed a type error in `SQLiteDatabase#updateWithOnConflict()`

## [0.3.3] - 2019-01-21
### Changed
- Added a default value for the bindings argument in `SQLiteDatabase#execSQL()`
- Added a default value for the bindings argument in `SQLiteDatabase#rawQuery()`

## [0.3.2] - 2018-12-08
### Changed
- Made `SQLiteCursor` iterable

## [0.3.1] - 2018-12-06
### Changed
- Fixed `Future<dynamic>` cast errors in several methods

## [0.3.0] - 2018-12-05
### Changed
- `SQLiteCursor#getBlob()` now returns a `Uint8List`, not a `ByteBuffer`

## [0.2.5] - 2018-12-05
### Added
- `SQLiteDatabase#updateWithOnConflict()` method

## [0.2.4] - 2018-12-04
### Added
- `SQLiteDatabase#insertOrThrow()` method
- `SQLiteDatabase#insertWithOnConflict()` method
- `SQLiteDatabase#replaceOrThrow()` method

## [0.2.3] - 2018-12-04
### Added
- `SQLiteDatabase#delete()` method
- `SQLiteDatabase#insert()` method
- `SQLiteDatabase#replace()` method
- `SQLiteDatabase#update()` method

## [0.2.2] - 2018-12-04
### Added
- `SQLiteDatabase#setForeignKeyConstraintsEnabled()` method
- `SQLiteDatabase#query()` method

## [0.2.1] - 2018-12-03
### Added
- `SQLiteDatabase#disableWriteAheadLogging()` method
- `SQLiteDatabase#enableWriteAheadLogging()` method

## [0.2.0] - 2018-12-01
### Changed
- Upgraded from SQLCipher 3.5.9 to
  [4.0.0](https://www.zetetic.net/blog/2018/11/30/sqlcipher-400-release/)

## [0.1.6] - 2018-11-30
### Added
- `SQLiteClosable` interface
- `SQLiteCursor#getBool()` method
- `SQLiteDatabase#close()` method

## [0.1.5] - 2018-11-30
### Added
- `SQLiteCursor#getDateTime()` method
- `SQLiteDatabase#isDatabaseIntegrityOk` getter
- `SQLiteDatabase#isDbLockedByCurrentThread` getter
- `SQLiteDatabase#getAttachedDbs()` method
- `SQLiteDatabase#validateSql()` method
- `SQLiteDatabase#yieldIfContendedSafely()` method
- `SQLiteDatatypeMismatchException` exception

## [0.1.4] - 2018-11-30
### Added
- `SQLiteDatabase#setMaxSqlCacheSize()` method
- `SQLiteDatabase#setMaximumSize()` method
- `SQLiteDatabase#setPageSize()` method
### Changed
- Made the second parameter to `SQLiteDatabase#rawQuery()` optional

## [0.1.3] - 2018-11-29
### Added
- `SQLiteDatabase.releaseMemory()` method
- `SQLiteDatabase#setTransactionSuccessful()` method
- `SQLiteDatabase#setVersion()` method

## [0.1.2] - 2018-11-23
### Added
- `SQLiteDatabase#inTransaction` getter
- `SQLiteDatabase#maximumSize` getter
- `SQLiteDatabase#pageSize` getter
- `SQLiteDatabase#getMaximumSize()` method
- `SQLiteDatabase#getPageSize()` method
- `SQLiteDatabase#needUpgrade()` method
### Changed
- Added an optional parameter to `SQLiteDatabase#execSQL()`

## [0.1.1] - 2018-11-23
### Added
- `SQLiteDatabase#beginTransaction()` method
- `SQLiteDatabase#beginTransactionNonExclusive()` method
- `SQLiteDatabase#endTransaction()` method

## [0.1.0] - 2018-11-22
### Added
- `SQLCipher.version` getter
- `SQLite.version` getter
- `SQLiteCursor` class and methods
- `SQLiteDatabase` class
- `SQLiteDatabase.*` constants
- `SQLiteDatabase.create()` method
- `SQLiteDatabase.createInMemory()` method
- `SQLiteDatabase.deleteDatabase()` method
- `SQLiteDatabase.openDatabase()` method
- `SQLiteDatabase.openOrCreateDatabase()` method
- `SQLiteDatabase#path` getter
- `SQLiteDatabase#version` getter
- `SQLiteDatabase#execSQL()` method
- `SQLiteDatabase#getPath()` method
- `SQLiteDatabase#getVersion()` method
- `SQLiteDatabase#isOpen` getter
- `SQLiteDatabase#isReadOnly` getter
- `SQLiteDatabase#isWriteAheadLoggingEnabled` getter
- `SQLiteDatabase#rawQuery()` method
- `SQLiteDatabase#setLocale()` method

[0.4.0]:  https://github.com/drydart/flutter_sqlcipher/compare/0.3.5...0.4.0
[0.3.5]:  https://github.com/drydart/flutter_sqlcipher/compare/0.3.4...0.3.5
[0.3.4]:  https://github.com/drydart/flutter_sqlcipher/compare/0.3.3...0.3.4
[0.3.3]:  https://github.com/drydart/flutter_sqlcipher/compare/0.3.2...0.3.3
[0.3.2]:  https://github.com/drydart/flutter_sqlcipher/compare/0.3.1...0.3.2
[0.3.1]:  https://github.com/drydart/flutter_sqlcipher/compare/0.3.0...0.3.1
[0.3.0]:  https://github.com/drydart/flutter_sqlcipher/compare/0.2.5...0.3.0
[0.2.5]:  https://github.com/drydart/flutter_sqlcipher/compare/0.2.4...0.2.5
[0.2.4]:  https://github.com/drydart/flutter_sqlcipher/compare/0.2.3...0.2.4
[0.2.3]:  https://github.com/drydart/flutter_sqlcipher/compare/0.2.2...0.2.3
[0.2.2]:  https://github.com/drydart/flutter_sqlcipher/compare/0.2.1...0.2.2
[0.2.1]:  https://github.com/drydart/flutter_sqlcipher/compare/0.2.0...0.2.1
[0.2.0]:  https://github.com/drydart/flutter_sqlcipher/compare/0.1.6...0.2.0
[0.1.6]:  https://github.com/drydart/flutter_sqlcipher/compare/0.1.5...0.1.6
[0.1.5]:  https://github.com/drydart/flutter_sqlcipher/compare/0.1.4...0.1.5
[0.1.4]:  https://github.com/drydart/flutter_sqlcipher/compare/0.1.3...0.1.4
[0.1.3]:  https://github.com/drydart/flutter_sqlcipher/compare/0.1.2...0.1.3
[0.1.2]:  https://github.com/drydart/flutter_sqlcipher/compare/0.1.1...0.1.2
[0.1.1]:  https://github.com/drydart/flutter_sqlcipher/compare/0.1.0...0.1.1
[0.1.0]:  https://github.com/drydart/flutter_sqlcipher/compare/0.0.6...0.1.0
