import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter_app/sqlfite/UserDatabase.dart';
import 'girisEkrani.dart';

abstract class Loginviewmodel extends State<login> {
  final emailcon = TextEditingController();
  final isimcon = TextEditingController();
  final genelcon = GlobalKey<FormState>();
  DateTime datetime;

  final userHelper = UserDatabase.instance;

  void getList() async {
    final allRows = await userHelper.getList();
    print('query all rows:');
    allRows.forEach(print);
  }
  Future getUserItem(int id) async {
    var userItem = await userHelper.getItem(id);
    print('Item : ${userItem}');
  }
  void insert (String name, String email, String photo, String date) async {
    Map<String, dynamic> row = {
      UserDatabase.columnName : name,
      UserDatabase.columnEmail : email,
      UserDatabase.columnPhoto : photo,
      UserDatabase.columnBirth : date,
    };
    final id = await userHelper.insert(row);
    print('inserted row id: $id');
  }
  void update(int id, String name, String email, String photo, String date) async {
    Map<String, dynamic> row = {
      UserDatabase.columnId   : id,
      UserDatabase.columnName : name,
      UserDatabase.columnEmail : email,
      UserDatabase.columnPhoto : photo,
      UserDatabase.columnBirth : date,
    };
    final rowsAffected = await userHelper.update(row);
    print('updated $rowsAffected row(s)');
  }
  void delete(int id) async {
    final rowsDeleted = await userHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
  void count() async {
    final id = await userHelper.queryRowCount();
    print('count : row $id');
  }

  @override
  void initState() {
    super.initState();
    emailcon.addListener(() => setState(() {}));
    isimcon.addListener(() => setState(() {}));
  }
  @override
  void dispose() {
    super.dispose();
    emailcon.dispose();
    isimcon.dispose();
  }

  File profilimage;
  Future _openGal(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      profilimage = picture;
    });
    Navigator.of(context).pop();
  }
  _openCam(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      profilimage = picture;
    });
    Navigator.of(context).pop();
  }
  Future<void> showcamgal(BuildContext context){
    return showDialog(context: context, barrierDismissible: true, builder: (BuildContext context){
      return AlertDialog(
        title: Text('Select one'),
        content: SingleChildScrollView(
          child: ListBody(
            children: [
              GestureDetector(child: Text('Galery'), onTap: (){_openGal(context);},),
              SizedBox(height: 10,),
              GestureDetector(child: Text('Camera'), onTap: (){_openCam(context);},),
            ],
          ),
        ),
      );
    });
  }
}