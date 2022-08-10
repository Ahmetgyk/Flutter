import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_app/sqlfite/DataMode.dart';
import 'package:flutter_app/sqlfite/UserDatabase.dart';
import 'package:flutter_app/sqlfite/PlanDatabase.dart';
import 'package:flutter_app/sqlfite/EventDatabase.dart';
import 'package:image_picker/image_picker.dart';
import 'userlist.dart';

abstract class UserListViewModel extends State<UserList> {
  final emailcon = TextEditingController();
  final isimcon = TextEditingController();
  final genelcon = GlobalKey<FormState>();
  DateTime datetime = DateTime.now();

  UserDatabase userDatabase;

  var userModel;

  List<UserModel> userList = [];

  Future getUserList() async {
    //userList = await userDatabase.getList();
    //print(userList.length.toString());
    setState(() {});
  }

  Future getUserItem(int id) async {
    var userItem = await userDatabase.getItem(id);
    print('Item : $userItem');
  }

  void saveModel() async {
    final result = await userDatabase.insert(userModel);
    //print(result);
  }

  @override
  void initState() {
    super.initState();
    //userDatabase = UserDatabase();
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