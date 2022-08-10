import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/utils.dart';
import 'dart:io';
import 'girisekraniviewmodel.dart';

import 'package:path_provider/path_provider.dart';

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

class Loginview extends Loginviewmodel {

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
                    insert(isimcon.text, emailcon.text, base64Image, datetime.toIso8601String());
                    getList();
                    setState(() {
                    });
                    //setState(() {Navigator.pop(context);});
                    },
                      child: Text('Tamam'))
                ],
              );
            }
        );
      }
    }
    Size size = MediaQuery.of(context).size;

    _profil(){
      if(profilimage == null)
        return Stack(
          children: [
            CircleAvatar(backgroundColor: Colors.white30, radius: size.width*0.3, child: Icon(Icons.account_circle, size: size.width*0.6, color: Colors.grey,)),
            Positioned(
                top: size.height*0.25,
                left: size.width*0.48,
                child: IconButton(icon: Icon(Icons.settings), onPressed: (){showcamgal(context);}, iconSize: 40,))
          ],
        );
      else
        return Stack(
          children: [
            ClipOval(child: Image.file(profilimage, height: size.width*0.8, width: size.width*0.8,), clipper: myclip(),),
            Positioned(
                top: size.height*0.25,
                left: size.width*0.55,
                child: IconButton(icon: Icon(Icons.settings), onPressed: (){showcamgal(context);}, iconSize: 40,))
          ],
        );

    }

    return Scaffold(
      body: Form(
        key: genelcon,
        child: SingleChildScrollView(
          child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/kizkul.jpg'), fit: BoxFit.cover)),
              child: Column(
                children: [
                  SizedBox(height: size.height*0.08,),
                  RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: 'Tour', style: TextStyle(color: Colors.blue, fontSize: 60,)),
                          TextSpan(text: 'Key', style: TextStyle(color: Color(0xffa5e65a), fontSize: 65)),
                        ]
                    ),
                  ),
                  SizedBox(
                    height: (size.height * 0.4),
                    child: Center(
                        child: _profil()
                    ),
                  ),
                  SizedBox(
                    width: size.width *0.8,
                    child: TextFormField(
                      //validator: (name){if(name.isEmpty){return 'please enter your user name';}},
                      controller: isimcon,
                      maxLength: 20,
                      decoration: InputDecoration(
                          fillColor: Colors.white24,
                          filled: true,
                          labelText: 'User Name',
                          prefixIcon: Icon(Icons.account_circle),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.green, width: 3)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.green, width: 3)),
                          suffixIcon: isimcon.text.isEmpty ? Container(width: 0) : IconButton(icon: Icon(Icons.close), onPressed: () => isimcon.clear())
                      ),
                      keyboardType: TextInputType.name,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(
                    width: size.width *0.8,
                    child: TextFormField(
                      //validator: (mail) => mail != null && !EmailValidator.validate(mail)? 'Enter a valid email' : null,
                      autofillHints: [AutofillHints.email],
                      controller: emailcon,
                      decoration: InputDecoration(
                          fillColor: Colors.white24,
                          filled: true,
                          hintText: 'please enter your email',
                          labelText: 'Email',
                          prefixIcon: Icon(Icons.email_outlined),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.green, width: 3)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Colors.green, width: 3)),
                          suffixIcon: emailcon.text.isEmpty
                              ? Container(width: 0) : IconButton(icon: Icon(Icons.close), onPressed: () => emailcon.clear())
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.done,
                    ),
                  ),
                  SizedBox(height: 10,),
                  datetime == null ? GestureDetector(
                      child: Container(
                          height: size.height*0.08,
                          width: size.width*0.8,
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
                                Text('Doğum tarihi', style: TextStyle(fontSize: 30,)),
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
                            final selDate = DateFormat.yMMMd().format(datetime);
                            Utils.showSnackBar(context, 'Selected "${selDate}"');
                            Navigator.pop(context);
                          }
                      )
                  ) : GestureDetector(
                      child: Container(
                          height: size.height*0.08,
                          width: size.width*0.8,
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
                            final selDate = DateFormat.yMMMd().format(datetime);
                            Utils.showSnackBar(context, 'Selected "${selDate}"');
                            Navigator.pop(context);
                          }
                      )
                  ),
                  SizedBox(height: 10,),
                  GestureDetector(
                      child: Container(
                          height: size.height*0.07,
                          width: size.width*0.8,
                          decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Colors.green) ,
                          child: Center(
                            child: Text('LOGIN', style: TextStyle(fontSize: 30,)),
                          )),
                      onTap: selamla
                  ),
                ],
              )
          ),
        ),
      ),
    );
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