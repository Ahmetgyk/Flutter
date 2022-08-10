import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/sqlfite/DataMode.dart';

class PlanDatabase{
  String _dbName = 'plandb.db';
  String dbTable = 'plans';
  int _version = 1;

  String columnId = 'id';
  String columnName = 'name';
  String columnBaslangicSehir = 'baslangicSehir';
  String columnBitisSehir = 'bitisSehir';
  String columnBaslangicTarih = 'baslangicTarih';
  String columnBitisTarih = 'bitisTarih';
  String columnPlanlar = 'planlar';

  PlanDatabase._privateConstructor();
  static final PlanDatabase instance = PlanDatabase._privateConstructor();

  static Database _database;
  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _dbName);
    return await openDatabase(path,
        version: _version,
        onCreate: _onCreate);
  }

  void _onCreate(Database db, int version) async {
    await db.execute(
        '''
        CREATE TABLE $dbTable (
        $columnId INTEGER PRIMARY KEY AUTOINCREMENT,
        $columnName TEXT,
        $columnBaslangicSehir TEXT,
        $columnBitisSehir TEXT,
        $columnBaslangicTarih TEXT,
        $columnBitisTarih TEXT, 
        $columnPlanlar TEXT)
     '''
    );
  }

  Future<List<PlanModel>> getList() async {
    if(database != null) _initDatabase();
    Database db = await instance.database;
    List<Map> userMaps = await db.query(dbTable);
    return userMaps.map((e) => PlanModel.fromJson(e)).toList();
  }

  Future<Map<String, dynamic>> getItem(int id) async {
    if(database != null) _initDatabase();
    Database db = await instance.database;
    final userMaps = await db.query(
      dbTable,
      where: '$columnId = ?',
      whereArgs: [id],
    );

    if(userMaps.isNotEmpty) return userMaps.first;
    else return null;
  }

  Future<int> insert(Map<String, dynamic> row) async {
    if(database != null) _initDatabase();
    Database db = await instance.database;
    return await db.insert(dbTable, row);
  }

  Future<int> queryRowCount() async {
    if(database != null) _initDatabase();
    Database db = await instance.database;
    return Sqflite.firstIntValue(await db.rawQuery('SELECT COUNT(*) FROM $dbTable'));
  }

  Future<int> delete(int id) async {
    if(database != null) _initDatabase();
    Database db = await instance.database;
    return await db.delete(dbTable, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Map<String, dynamic> row) async {
    if(database != null) _initDatabase();
    Database db = await instance.database;
    int id = row[columnId];
    return await db.update(dbTable, row, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    Database db = await instance.database;
    await db.close();
  }
}