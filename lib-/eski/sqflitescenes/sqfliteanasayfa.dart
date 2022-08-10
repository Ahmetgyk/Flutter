import 'package:flutter_app/sqfliteutils/sqflitehelper.dart';
import 'package:flutter_app/sqflitemodel/cars.dart';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';

class MyPage extends StatefulWidget {
  @override
  _MyPageState createState() => _MyPageState();
}

class _MyPageState extends State<MyPage> {
  final dbhelper = DbHelper.instance;
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  List<Car> cars = [];
  List<Car> carsbyName = [];

  TextEditingController nameCon = TextEditingController();
  TextEditingController milesCon = TextEditingController();
  TextEditingController queryCon = TextEditingController();
  TextEditingController idUpdateCon = TextEditingController();
  TextEditingController nameUpdateCon = TextEditingController();
  TextEditingController milesUpdateCon = TextEditingController();
  TextEditingController idDeleteCon = TextEditingController();

  void _showMessage(String message){
    _scaffoldkey.currentState.showSnackBar(
      SnackBar(
        content: Text(message),
      )
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(),
      home: DefaultTabController(
          length: 5,
          child: Scaffold(
            key: _scaffoldkey,
            appBar: AppBar(
              title: Text('SQFLITE'),
              bottom: TabBar(
                tabs: [
                  Tab(
                    text: 'Insert',
                  ),
                  Tab(
                    text: 'View',
                  ),
                  Tab(
                    text: 'Query',
                  ),
                  Tab(
                    text: 'Update',
                  ),
                  Tab(
                    text: 'Delete',
                  ),
                ],
              ),
            ),
            body: TabBarView(
              children: [
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          controller: nameCon,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Car Name'
                          ),
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          controller: milesCon,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Miles Name'
                          ),
                        ),
                      ),
                      RaisedButton(
                          child: Text('Insert Car'),
                          onPressed: (){
                            String name = nameCon.text;
                            int miles = int.parse(milesCon.text);
                            _insert(name, miles);
                          }
                      )
                    ],
                  ),
                ),
                Container(
                  child: ListView.builder(
                    padding: EdgeInsets.all(8),
                    itemCount: cars.length + 1,
                    itemBuilder: (BuildContext context, int index){
                      if(index == cars.length){
                        return RaisedButton(
                          child: Text('Reflesh'),
                          onPressed: (){
                            setState(() {
                              _queryAll();
                            });
                          },
                        );
                      }
                      return Container(
                        height: 40,
                        child: Center(
                          child: Text('[${cars[index].id}] ${cars[index].name} - ${cars[index].miles} miles',
                            style: TextStyle(fontSize: 18),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          controller: queryCon,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Car Name'
                          ),
                          onChanged: (text){
                            if(text.length >= 2){
                              setState(() {
                                _query(text);
                              });
                            }
                            else{
                              setState(() {
                                carsbyName.clear();
                              });
                            }
                          },
                        ),
                      ),
                      Expanded(
                        child: Container(
                          height: 300,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(8),
                            itemCount: carsbyName.length,
                            itemBuilder: (BuildContext context, int index){
                              return Container(
                                height: 50,
                                margin: EdgeInsets.all(2),
                                child: Center(
                                    child: Text(
                                      '[${carsbyName[index].id}] ${carsbyName[index].name} - ${carsbyName[index].miles} miles',
                                      style: TextStyle(fontSize: 18),)
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        Container(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            controller: idUpdateCon,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Car Name'
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            controller: nameUpdateCon,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Car Name'
                            ),
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(20),
                          child: TextField(
                            controller: milesUpdateCon,
                            decoration: InputDecoration(
                                border: OutlineInputBorder(),
                                labelText: 'Miles Name'
                            ),
                          ),
                        ),
                        RaisedButton(
                            child: Text('Update Car'),
                            onPressed: (){
                              int id = int.parse(idUpdateCon.text);
                              String name = nameCon.text;
                              int miles = int.parse(milesCon.text);
                              _update(id, name, miles);
                            }
                        )
                      ],
                    ),
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.all(20),
                        child: TextField(
                          controller: idDeleteCon,
                          decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Car id'
                          ),
                        ),
                      ),
                      RaisedButton(
                          child: Text('Delete Car'),
                          onPressed: (){
                            int id = int.parse(idUpdateCon.text);
                            _delete(id);
                          }
                      )
                    ],
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }

  void _insert(String name, int miles) async {
    Map<String, dynamic> row = {
      DbHelper.columnName : name,
      DbHelper.columnMiles : miles
    };

    Car car = Car.fromMap(row);
    final id = await dbhelper.insert(car);
    _showMessage('inserted row id : $id');
  }

  void _queryAll() async {
    final allRows = await dbhelper.queryAllRows();
    cars.clear();
    allRows.forEach((row) => cars.add(Car.fromMap(row)));
    _showMessage('Query done');
    setState(() {
      
    });
  }

  void _query(name) async {
    final allRows = await dbhelper.queryRows(name);
    carsbyName.clear();
    allRows.forEach((row) => carsbyName.add(Car.fromMap(row)));
  }

  void _update(int id, String name, int miles) async {
    Car car = Car(id, name, miles);
    final rowAffected = await dbhelper.update(car);
    _showMessage('Update $rowAffected row(s)');
  }

  void _delete(int id) async {
    final rowDeleted = await dbhelper.delete(id);
    _showMessage('Delete $rowDeleted row(s) : rows $id');
  }
}
