import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/utils.dart';
import 'dart:io';

import 'package:flutter_app/anaSayfa.dart';
import 'package:flutter_app/server.dart';

class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}

class login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}
class _LoginState extends State<login> {
  final emailcon = TextEditingController();
  final isimcon = TextEditingController();
  final genelcon = GlobalKey<FormState>();
  DateTime datetime = DateTime.now();

  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {

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
                      Text('Your e-mail address is saved as ${emailcon.text}')
                    ],
                  ),
                ),
                actions: [
                  FlatButton(onPressed:() {setState(() {
                    Navigator.pop(context);
                    profil['resim'] = profilimage;
                    profil['ad'] = isimcon.text;
                    profil['email'] = emailcon.text;
                    profil['dogutarihi'] = datetime;
                    print(profilimage);
                    Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => AnaSayfa()));
                  });}, child: Text('Tamam'))
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
                      validator: (name){if(name.isEmpty){return 'please enter your user name';}},
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
                      validator: (mail) => mail != null && !EmailValidator.validate(mail)? 'Enter a valid email' : null,
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
                  GestureDetector(
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