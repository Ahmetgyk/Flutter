import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_app/sehirsayfa.dart';
import 'package:flutter_app/sqflitemodel/cars.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _dbName = 'cardb.db';
  static final _dbVersion = 2;
  static final table = 'cars_tabe';
  static final columnID = 'id';
  static final columnName = 'name';
  static final columnMiles = 'miles';

  DbHelper._privateConstructor();
  static final DbHelper instance = DbHelper._privateConstructor();
  static Database _database;

  Future<Database> get database async{
    if(_database != null) return _database;
    _database = await _initDatebase();
  }

  _initDatebase() async {
    String path = join(await getDatabasesPath(), _dbName);
    return await openDatabase(path,
      version: _dbVersion,
      onCreate: _onCreate
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('CREATE TABLE $table ( $columnID INTEGER PRIMARY KEY AUTOINCREMENT, $columnName TEXT NOT NULL, $columnMiles TEXT NOT NULL )');
  }

  Future<int> insert(Car car) async {
    Database db = await instance.database;
    return await db.insert(table, {'name' : car.name, 'miles' : car.miles});
  }

  Future<int> update(Car car) async {
    Database db = await instance.database;
    int id = car.toMap()['id'];
    return await db.update(table, car.toMap(), where: '$columnID = ?', whereArgs: [id]);
  }

  Future<int> delete(int id) async {
    Database db = await instance.database;
    return await db.delete(table, where: '$columnID = ?', whereArgs: [id]);
  }

  Future<List<Map<String, dynamic>>> queryRows(name) async {
    Database db = await instance.database;
    return await db.query(table, where: "$columnName LIKE '%$name%'");
  }

  Future<List<Map<String, dynamic>>> queryAllRows() async {
    Database db = await instance.database;
    return await db.query(table);
  }

  Future<int> queryRowsCount() async {
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $table'));
  }
}