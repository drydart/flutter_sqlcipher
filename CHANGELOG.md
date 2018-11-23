Changelog
---------

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

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

[0.1.2]:  https://github.com/drydart/flutter_sqlcipher/compare/0.1.1...0.1.2
[0.1.1]:  https://github.com/drydart/flutter_sqlcipher/compare/0.1.0...0.1.1
[0.1.0]:  https://github.com/drydart/flutter_sqlcipher/compare/0.0.6...0.1.0
