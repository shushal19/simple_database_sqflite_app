// ignore_for_file: depend_on_referenced_packages

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static const _databaseName = "persons.db";
  static const _databaseVersion = 1;
  static const table = "my_table";
  static const colID = 'id';
  static const colName = 'name'; // Removed "late" keyword
  static const colAge = 'age';
  static Database? _database;
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  Future<Database> get database async {
    if (_database != null) return _database!;
    // Initialize the DB first time it is accessed
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasePath = await getDatabasesPath();

    // Set the path to the database using the join function from the path package.
    final path = join(databasePath, _databaseName);

    // Set the version and configure database settings.
    return await openDatabase(
      path,
      onCreate: _onCreate,
      version: _databaseVersion,
      onConfigure: (db) async => await db.execute('PRAGMA foreign_keys = ON'),
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    // Run the CREATE TABLE statement on the database.
    await db.execute(
      'CREATE TABLE $table($colID INTEGER PRIMARY KEY,$colName TEXT NOT NULL,$colAge INTEGER NOT NULL)',
    );
  }

  // Function to insert data into the database.
  Future<int> insert(Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(table, row);
  }

  //query all rows
  Future<List<Map<String, dynamic>>> queryAll() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  //query specific

  Future<List<Map<String, dynamic>>> querySpecific(int age) async {
    Database db = await instance.database;
    var res = await db.query(table, where: "age > ?", whereArgs: [age]);
    return res;
  }
//delete data

  Future<int> deletedata(int id) async {
    Database db = await instance.database;
    var res = await db.delete(table, where: "id = ?", whereArgs: [id]);
    return res;
  }

  //update data

  Future<int> updateData(int id) async {
    Database db = await instance.database;
    var res = await db.update(table, {"name": "Shusal lamsal", "age": "8"},
        where: "id = ?", whereArgs: [id]);
    return res;
  }
}
