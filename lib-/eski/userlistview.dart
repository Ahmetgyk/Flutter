import 'dart:convert';
import 'dart:io';

import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/utils.dart';
import 'package:path_provider/path_provider.dart';
import 'userlistviewmodel.dart';
import 'package:intl/intl.dart';
import 'Sayfalar/anaSayfa.dart';

class DisplayPictureScreen extends StatefulWidget {
  final String imageAnalysed;
  const DisplayPictureScreen({Key key, this.imageAnalysed}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}
class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File fileImg;
  bool isLoading = true;

  void writeFile() async {
    final decodedBytes = base64Decode(widget.imageAnalysed);
    final directory = await getApplicationDocumentsDirectory();
    fileImg = File('${directory.path}/testImage.png');
    print(fileImg.path);
    fileImg.writeAsBytesSync(List.from(decodedBytes));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      writeFile();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator() : Image.file(fileImg);
  }
}

class UserListView extends UserListViewModel {
  int i = 20;
  DateTime datetime = DateTime.now();

  double width = 500.0;
  double height = 800.0;

  @override
  Widget build(BuildContext context) {
    Widget res(){
      List<int> imageBytes = profilimage.readAsBytesSync();
      print(imageBytes);
      String base64Image = base64Encode(imageBytes);
      return DisplayPictureScreen(imageAnalysed: base64Image);
    }
    void selamla(){
      if(genelcon.currentState.validate()){
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context){
              return AlertDialog(
                title: Text('welcome to our family'),
                content: SingleChildScrollView(
                  child: ListBody(
                    children: [
                      Text('Hello ${isimcon.text}'),
                      Text('Your e-mail address is saved as ${emailcon.text}'),
                      res()
                    ],
                  ),
                ),
                actions: [
                  FlatButton(onPressed:() {
                    List<int> imageBytes = profilimage.readAsBytesSync();
                    print(imageBytes);
                    String base64Image = base64Encode(imageBytes);
                    userModel.photo = "base64Image";
                    userModel.name = isimcon.text;
                    userModel.email = emailcon.text;
                    userModel.born = "datetime.toIso8601String()";
                    print(userModel.toJson());
                    saveModel();
                    getUserList();
                    setState(() {
                      Navigator.pop(context);
                    });}, child: Text('Tamam'))
                ],
              );
            }
        );
      }
    }
    _profil(){
      if(profilimage == null)
        return Stack(
          children: [
            CircleAvatar(backgroundColor: Colors.white30, radius: width*0.3, child: Icon(Icons.account_circle, size: width*0.6, color: Colors.grey,)),
            Positioned(
                top: height*0.25,
                left: width*0.48,
                child: IconButton(icon: Icon(Icons.settings), onPressed: (){showcamgal(context);}, iconSize: 40,))
          ],
        );
      else
        return Stack(
          children: [
            ClipOval(child: Image.file(profilimage, height: width*0.8, width: width*0.8,), clipper: myclip(),),
            Positioned(
                top: height*0.25,
                left: width*0.55,
                child: IconButton(icon: Icon(Icons.settings), onPressed: (){showcamgal(context);}, iconSize: 40,))
          ],
        );

    }

    return MaterialApp(
      home:  Scaffold(
      body: SingleChildScrollView(
        child: Container(
            width: width,
            height: height,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/kizkul.jpg'), fit: BoxFit.cover)),
            child: Column(
              children: [
                SizedBox(height: height*0.08,),
                RichText(
                  text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(text: 'Tour', style: TextStyle(color: Colors.blue, fontSize: 60,)),
                        TextSpan(text: 'Key', style: TextStyle(color: Color(0xffa5e65a), fontSize: 65)),
                      ]
                  ),
                ),
                SizedBox(
                  height: (height * 0.4),
                  child: Center(
                      child: _profil()
                  ),
                ),
                SizedBox(
                  width: width *0.8,
                  child: TextField(
                    onChanged: (value) => userModel.name = value,
                    decoration: InputDecoration(
                        hintText: 'user name', border: OutlineInputBorder()
                    ),
                  ),
                ),
                SizedBox(
                  width: width *0.8,
                  child: TextField(
                    onChanged: (value) => userModel.email = value,
                    decoration: InputDecoration(
                        hintText: 'user name', border: OutlineInputBorder()
                    ),
                  ),
                ),
                SizedBox(height: 10,),
                GestureDetector(
                    child: Container(
                        height: height*0.08,
                        width: width*0.8,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(16)), color: Colors.white30,
                            border: Border.all(width: 3, color: Colors.green)
                        ) ,
                        child: Center(
                          child: Row(
                            children: [
                              SizedBox(width: 15,),
                              Icon(Icons.calendar_today, size: 20, color: Colors.black54,),
                              SizedBox(width: 20,),
                              Text(DateFormat.yMMMd().format(datetime), style: TextStyle(fontSize: 30,)),
                            ],
                          ),
                        )),
                    onTap: () => Utils.showSheet(
                        context,
                        child: SizedBox(height: 180,
                            child: CupertinoDatePicker(
                              minimumYear: 1900,
                              maximumYear: DateTime.now().year,
                              initialDateTime: datetime,
                              mode: CupertinoDatePickerMode.date,
                              onDateTimeChanged: (datetime){setState(() {this.datetime = datetime;});},
                            )),
                        onClicked: (){
                          userModel.born = datetime.toIso8601String();
                          final selDate = DateFormat.yMMMd().format(datetime);
                          Utils.showSnackBar(context, 'Selected "${selDate}"');
                          Navigator.pop(context);
                        }
                    )
                ),
                SizedBox(height: 10,),
                GestureDetector(
                    child: Container(
                        height: height*0.07,
                        width: width*0.8,
                        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.green) ,
                        child: Center(
                          child: Text('LOGIN', style: TextStyle(fontSize: 30,)),
                        )),
                    onTap: () {
                      userModel.photo = "base64Image";
                      userModel.name = "sfses";
                      userModel.born = "datetime.toIso8601String()";
                      print(userModel.toJson());
                      saveModel();
                      getUserList();
                      ;},
                ),
              ],
            )
        ),
      ),
      ),
    );
  }

  Center get buildCenter {
    return Center(
        child: Column(
          children: [
            Spacer(),
            Expanded(child: buildWrap),
            Spacer(),
            Flexible(
              child: ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) => ListTile(
                  title: Text(userList[index].name),
                  subtitle: Text("userList[index].email"),
                  trailing: Text("userList[index].born"),
                )
              ),
            )
          ],
        ),
      );
  }

  Wrap get buildWrap {
    return Wrap(
        runSpacing: 20,
        children: [
          GestureDetector(
              child: Container(
                  height: 60,
                  width: 300,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(16)), color: Colors.white30,
                      border: Border.all(width: 3, color: Colors.green)
                  ) ,
                  child: Center(
                    child: Row(
                      children: [
                        SizedBox(width: 15,),
                        Icon(Icons.calendar_today, size: 20, color: Colors.black54,),
                        SizedBox(width: 20,),
                        Text(DateFormat.yMMMd().format(datetime), style: TextStyle(fontSize: 30,)),
                      ],
                    ),
                  )),
              onTap: () => Utils.showSheet(
                  context,
                  child: SizedBox(height: 180,
                      child: CupertinoDatePicker(
                        minimumYear: 1900,
                        maximumYear: DateTime.now().year,
                        initialDateTime: datetime,
                        mode: CupertinoDatePickerMode.date,
                        onDateTimeChanged: (datetime){setState(() {this.datetime = datetime;});},
                      )),
                  onClicked: (){
                    userModel.born = datetime.toIso8601String();
                    final selDate = DateFormat.yMMMd().format(datetime);
                    Utils.showSnackBar(context, 'Selected "${selDate}"');
                    Navigator.pop(context);
                  }
              )
          ),
          TextField(
            onChanged: (value) => userModel.name = value,
            decoration: InputDecoration(
              hintText: 'user name', border: OutlineInputBorder()
            ),
          ),
          TextField(
            onChanged: (value) => userModel.email = value,
            decoration: InputDecoration(
                hintText: 'email', border: OutlineInputBorder()
            ),
          ),
          TextField(
            onChanged: (value) => userModel.photo = '/data/user/0/com.example.tourkey_app/cache/image_picker3565943304780944396.jpg',
            decoration: InputDecoration(
                hintText: 'photo', border: OutlineInputBorder()
            ),
          ),
        ],
      );
  }

  FloatingActionButton buildFloatingActionButton() {
    return FloatingActionButton(onPressed: (){
      print(userModel.toJson());
      saveModel();
      getUserList();
    },);
  }
}
class myclip extends CustomClipper<Rect>{
  @override
  Rect getClip(Size size) {
    return Rect.fromLTWH(size.width*0.15, size.width*0.05, size.width*0.7, size.width*0.7);
  }

  @override
  bool shouldReclip(covariant CustomClipper<Rect> oldClipper) {
    return true;
  }
}
