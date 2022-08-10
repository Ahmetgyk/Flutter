
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'hivveri.dart';

void main() async {
  await Hive.initFlutter();
  runApp(hiveDeneme());
}


abstract class IHomeService {
  final Dio dio;
  final _userPath = "/users";

  IHomeService(this.dio);
  Future<List<Usermmodel>> fetchUsers();
}
class HomeService extends IHomeService {
  HomeService(Dio dio) : super(dio);

  Future<List<Usermmodel>> fetchUsers() async{
    final response = await dio.get(_userPath);
    
    // if(response.statusCode == HttpStatus.ok){
    //   final responses = response.data;
    //   if(responses is List){
    //     return responses.map((e) => Usermmodel.fromJson(e)).toList();
    //   }
    // }
    return null;
  }
}




class hiveDeneme extends StatefulWidget {
  @override
  _hiveDenemeState createState() => _hiveDenemeState();
}
class _hiveDenemeState extends State<hiveDeneme> {
  IHomeService _homeService;
  final String _baseUrl = "https://jsonplaceholder.typicode.com";
  List<Usermmodel> _items;
  IChaceManager<Usermmodel> chaceManager;


  @override
  void initState() {
    super.initState();
    _homeService = HomeService(Dio(BaseOptions(baseUrl: _baseUrl)));
    chaceManager = UserCacheManager('userChace');
    fetchDatas();
  }

  Future<void> fetchDatas() async{
    await Hive.initFlutter();
    chaceManager.init();

    if(chaceManager.getValues() != null){
      _items = await chaceManager.getValues();
    }
    else{
      _items = await _homeService.fetchUsers();
    }
    setState(() {});
  }

  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: Scaffold(
        appBar: AppBar(),
        floatingActionButton: FloatingActionButton(
          onPressed: () async {
            if(_items?.isNotEmpty ?? false){
              await chaceManager.addItems(_items);
            }
          },
        ),
        body: (_items?.isNotEmpty ?? false)?ListView.builder(
          itemCount: _items?.length,
          itemBuilder: (context, index){
            return Card(
              child: ListTile(
                title: Text("${_items[index].name}"),
              ),
            );
          }
        ):CircularProgressIndicator(),
      ),
    );
  }
}

abstract class IChaceManager<T>{
  final String key;
  Box<Usermmodel> _box;

  IChaceManager(this.key);
  Future<void> init() async{
    if(!(_box?.isOpen ?? true)){
      _box = await Hive.openBox(key);
    }
  }
  Future<void> addItems(List<T> item);
  Future<void> putItem(List<T> item);
  T getItem(String key);
  Future<void> putItems(String key, T item);
  Future<void> removeItems(String key);
  Future<void> clearAll(String key) async{
    await _box?.clear();
  }
  List<Usermmodel> getValues();
}
class UserCacheManager extends IChaceManager<Usermmodel>{
  UserCacheManager(String key) : super(key);

  @override
  Future<void> addItems(List<Usermmodel> item) async{
    await _box?.addAll(item);
  }

  @override
  Future<void> putItem(List<Usermmodel> item) async{
    await _box?.putAll(Map.fromEntries(item.map((e) => MapEntry(e.id, e))));
  }

  @override
  Usermmodel getItem(String key) {
    return _box?.get(key);
  }

  @override
  Future<void> putItems(String key, Usermmodel item) async{
    await _box?.put(key, item);
  }

  @override
  Future<void> removeItems(String key) async{
    await _box?.delete(key);
  }

  @override
  List<Usermmodel> getValues(){
    return _box?.values.toList();
  }

  @override
  void registerAdapters(){
    if(!Hive.isAdapterRegistered(1)){
      //Hive.registerAdapter()
    }
  }
}