import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/sqlfite/DataMode.dart';

class EventDatabase{
  int _version = 1;

  String columnId = 'id';
  String columnYer = 'yer';
  String columnHaraket = 'haraket';
  String columnIcon = 'icon';
  String columnBaslandic = 'baslangic';
  String columnBiris = 'bitis';

  EventDatabase._privateConstructor();
  static final EventDatabase instance = EventDatabase._privateConstructor();

  static Database _database;
  Future<Database> database(String tablename) async {
    if (_database != null) return _database;
    _database = await _initDatabase(tablename);
    return _database;
  }
  _initDatabase(String tablename) async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, '${tablename}db.db');
    return await openDatabase(path,
        version: _version,
        onCreate: (db, version){
          _onCreate(db, version, tablename);
        }
    );
  }

  void _onCreate(Database db, int version, String tablename) async {
    await db.execute(
        '''
        CREATE TABLE $tablename (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnYer TEXT,
        $columnHaraket TEXT,
        $columnIcon TEXT,
        $columnBaslandic TEXT,
        $columnBiris TEXT)
     '''
    );
  }

  Future<List<PlanModel>> getList(String tablename) async {
    Database db = await instance.database(tablename);
    List<Map> userMaps = await db.query(tablename);
    return userMaps.map((e) => PlanModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getItem(int id, String tablename) async {
    Database db = await instance.database(tablename);
    final userMaps = await db.query(
      tablename,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if(userMaps.isNotEmpty) return userMaps.first;
    else return null;
  }

  Future<int> insert(Map<String, dynamic> row, String tablename) async {
    Database db = await instance.database(tablename);
    return await db.insert(tablename, row);
  }

  Future<int> queryRowCount(String tablename) async {
    Database db = await instance.database(tablename);
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $tablename'));
  }

  Future<int> delete(int id, String tablename) async {
    Database db = await instance.database(tablename);
    return await db.delete(tablename, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Map<String, dynamic> row, String tablename) async {
    Database db = await instance.database(tablename);
    int id = row[columnId];
    return await db.update(tablename, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> close(String tablename) async {
    Database db = await instance.database(tablename);
    await db.close();
  }
}