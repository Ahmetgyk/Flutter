import 'package:path_provider/path_provider.dart';
import 'package:flutter_app/photo/photo.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'dart:io' as io;
import 'dart:async';

class DBHelper{
  int _version = 1;
  static Database _db;

  static String columnId = 'id';
  static String columnName = 'name';
  static String _dbName = 'photos';
  static String _dbTable = 'photosTable';

  Future<void> open() async {
    _db = await openDatabase(
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
        $columnName TEXT,)
     '''
    );
  }

  Future<List<Photo>> getList() async {
    if(_db != null) open();
    List<Map> maps = await _db.query(_dbTable, columns: [columnId, columnName]);
    List<Photo> photos = [];
    if(maps.length > 0){
      for(int i = 0; i < maps.length; i ++){
        photos.add(Photo.fromMap(maps[i]));
      }
    }
    return photos;
  }
  Future<Photo> save (Photo photo) async {
    if(_db != null) open();
    photo.id = await _db.insert(_dbTable, photo.toMap());
    return photo;
  }
  Future<void> close() async {
    await _db.close();
  }
}