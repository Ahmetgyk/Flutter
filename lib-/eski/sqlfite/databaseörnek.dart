import 'package:sqflite/sqflite.dart';
import 'package:flutter_app/sqlfite/DataMode.dart';
import 'dart:async';

class PlanDatabase{
  String _dbName = 'planDb';
  String _dbTable = 'plan';
  int _version = 1;
  Database database;

  String columnId = 'id';
  String columnName = 'name';
  String columnBaslangc = 'baslangc';
  String columnBitis = 'bitis';
  String columnPlanlar = 'planlar';

  Future<void> open() async {
    database = await openDatabase(
        _dbName,
        version: _version,
        onCreate: (db, version){
          createTable(db);
        }
    );
  }

  void createTable(Database db) {
    db.execute(
        '''
        CREATE TABLE $_dbTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName VARCHAR(20),
        $columnBaslangc TEXT,
        $columnBitis TEXT, 
        $columnPlanlar TEXT)
     '''
    );
  }

  Future<List<UserModel>> getList() async {
    if(database != null) open();
    List<Map> userMaps = await database.query(_dbTable);
    return userMaps.map((e) => UserModel.fromJson(e)).toList();
  }

  Future<UserModel> getItem(int id) async {
    if(database != null) open();
    final userMaps = await database.query(
      _dbTable,
      where: '$columnId = ?',
      columns: [columnId],
    );

    if(userMaps.isNotEmpty) return UserModel.fromJson(userMaps.first);
    else return null;
  }

  Future<bool> insert(UserModel model) async {
    if(database != null) open();
    final userMaps = await database.insert(
      _dbTable,
      model.toJson(),
    );

    return userMaps != null;
  }

  Future<bool> delete(int id) async {
    if(database != null) open();
    final userMaps = await database.delete(
      _dbTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return userMaps != null;
  }

  Future<bool> update(int id, UserModel model) async {
    if(database != null) open();
    final userMaps = await database.update(
      _dbTable,
      model.toJson(),
      where: '$columnId = ?',
      whereArgs: [id],
    );

    return userMaps != null;
  }

  Future<void> close() async {
    await database.close();
  }
}