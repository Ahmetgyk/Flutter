import 'package:flutter_app/sqfliteutils/sqflitehelper.dart';

class Car {
  int id;
  String name;
  int miles;

  Car(this.id, this.name, this.miles);

  Car.fromMap(Map<String, dynamic> map){
    id = map['id'];
    name = map['name'];
    miles = map['miles'];
  }

  Map<String, dynamic> toMap(){
    return{
      DbHelper.columnID: id,
      DbHelper.columnName: name,
      DbHelper.columnMiles: miles,
    };
  }
}