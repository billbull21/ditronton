import 'dart:async';

import 'package:sqflite/sqflite.dart';

class DBInstance {
  static DBInstance? _databaseHelper;
  DBInstance._instance() {
    _databaseHelper = this;
  }

  factory DBInstance() => _databaseHelper ?? DBInstance._instance();

  static Database? _database;

  Future<Database?> get database async {
    _database ??= await _initDb();
    return _database;
  }

  static const String movieTblWatchlist = 'watchlist_movie';
  static const String tvTblWatchlist = 'watchlist_tv';

  Future<Database> _initDb() async {
    final path = await getDatabasesPath();
    final databasePath = '$path/movie_dicoding_app.db';

    var db = await openDatabase(databasePath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);
    return db;
  }

  void _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE  $movieTblWatchlist (
        id INTEGER PRIMARY KEY,
        title TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
    await db.execute('''
      CREATE TABLE  $tvTblWatchlist (
        id INTEGER PRIMARY KEY,
        name TEXT,
        overview TEXT,
        posterPath TEXT
      );
    ''');
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < newVersion) {
      // Perform database upgrade logic here
    }
  }
}
