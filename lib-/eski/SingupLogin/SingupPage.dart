import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Sayfalar/anaSayfa.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/init/profilprovider.dart';
import 'package:flutter_app/init/theme.dart';
import 'package:flutter_app/init/themeprovider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'package:flutter_app/sqlfite/UserDatabase.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}
class _SingUpPageState extends State<SingUpPage> {
  final isimcon = TextEditingController();
  final emailcon = TextEditingController();
  final parolacon = TextEditingController();
  final genelcon = GlobalKey<FormState>();
  final userHelper = UserDatabase.instance;
  DateTime datetime;

  bool tr = false;

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
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    _profil(){
      if(profilimage == null)
        return Stack(
          children: [
            CircleAvatar(backgroundColor
                : Colors.white30, radius: w*0.3, child: Icon(Icons.account_circle, size: w*0.6, color: Colors.grey,)),
            Positioned(
                top: h*0.25,
                left: w*0.48,
                child: IconButton(icon: Icon(Icons.settings), onPressed: (){showcamgal(context);}, iconSize: 40,))
          ],
        );
      else
        return Stack(
          children: [
            ClipOval(child: Image.file(profilimage, height: w*0.8, width: w*0.8,), clipper: myclip(),),
            Positioned(
                top: h*0.25,
                left: w*0.55,
                child: IconButton(icon: Icon(Icons.settings), onPressed: (){showcamgal(context);}, iconSize: 40,))
          ],
        );

    }

    void Tarih(){
      if(genelcon.currentState.validate()){
        showDialog(
            context: context,
            barrierDismissible: true,
            builder: (context){
              return AlertDialog(
                backgroundColor: Color(0xffbC0C0C0),
                title: Text('Doğum tarihi', style: TextStyle(fontSize: 20, color: Colors.black,)),
                content: SizedBox(
                    height: 180,
                    child: CupertinoDatePicker(
                      minimumYear: 1900,
                      maximumYear: DateTime.now().year,
                      initialDateTime: datetime,
                      mode: CupertinoDatePickerMode.date,
                      onDateTimeChanged: (datetime){setState(() {this.datetime = datetime;});},
                    )
                ),
                actions: [FlatButton(onPressed:() {setState(() {Navigator.pop(context);});}, child: Text('Tamam'))],
              );
            }
        );
      }
    }

    String makebase64(){
      if(profilimage != null){
        List<int> imageBytes = profilimage.readAsBytesSync();
        print(imageBytes);
        String base64Image = base64Encode(imageBytes);
        return base64Image;
      }
      else return null;
    }
    Future<void> SingUp(String email, String parola, String isim, String datetime) async {
      String name = Provider.of<CostumProfilData>(context, listen: false).name;
      String mail = Provider.of<CostumProfilData>(context, listen: false).email;
      String password = Provider.of<CostumProfilData>(context, listen: false).password;
      String profil = Provider.of<CostumProfilData>(context, listen: false).profil;
      String id = Provider.of<CostumProfilData>(context, listen: false).id;
      String date = Provider.of<CostumProfilData>(context, listen: false).date;
      String dil = Provider.of<CostumProfilData>(context, listen: false).dil;
      String tema = Provider.of<CostumProfilData>(context, listen: false).tema;

      bool tr = context.locale.languageCode == 'en' ? false : true;
      bool dark = Provider.of<CostumThemeData>(context, listen: false).getThemeData == lighttheme ? false : true;

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: parola)
          .then((kullanici) async {
        await FirebaseFirestore.instance.collection("kullanicilar").doc(kullanici.user.uid)
            .set({"date": datetime, "name" : isim});
        await FirebaseFirestore.instance.collection("kullanicilar").doc(kullanici.user.uid)
            .collection("planlar").doc("${kullanici.user.uid}.plan").set({"planadi": {"planadi": isim}});
        var res = await FirebaseFirestore.instance.collection("kullanicilar").doc(kullanici.user.uid)
            .collection("planlar").doc("${kullanici.user.uid}.plan").get();

        Provider.of<CostumProfilData>(context, listen: false)
            .setProfiData({name : isim, password : parola, mail : email, id : kullanici.user.uid, date : datetime});

        res.data()["planadi"]["planadi"];
      });
    }
    Future<void> kayitol(String email, String parola, String isim, String datetime,) async {
      String name = Provider.of<CostumProfilData>(context, listen: false).name;
      String mail = Provider.of<CostumProfilData>(context, listen: false).email;
      String password = Provider.of<CostumProfilData>(context, listen: false).password;
      String id = Provider.of<CostumProfilData>(context, listen: false).id;
      String date = Provider.of<CostumProfilData>(context, listen: false).date;

      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email, password: parola)
          .then((kullanici) async {
        FirebaseFirestore.instance.collection("kullanicilar").doc(kullanici.user.uid)
            .set({"date": datetime, "name" : isim});
        FirebaseFirestore.instance.collection("kullanicilar").doc(kullanici.user.uid)
            .collection("planlar").doc("${kullanici.user.uid}.plan").set({"planadi": {"planadi": isim}});
        var res = await FirebaseFirestore.instance.collection("kullanicilar").doc(kullanici.user.uid)
            .collection("planlar").doc("${kullanici.user.uid}.plan").get();

        Provider.of<CostumProfilData>(context, listen: false)
            .setProfiData({name : isim, password : parola, mail : email, id : kullanici.user.uid, date : datetime});

        res.data()["planadi"]["planadi"];
      });
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: parola)
          .then((kullanici) async {
        var res = await FirebaseFirestore.instance.collection("kullanicilar").doc(kullanici.user.uid)
            .collection("planlar").doc("${kullanici.user.uid}.plan").get();
      });
    }

    return Scaffold(
      body: Form(
        key: genelcon,
        child: SingleChildScrollView(
          child: Container(
            width: w, height: h * 1.05, color: Color(0xff30475E),
            child: Column(
              children: [
                SizedBox(
                  height: (h * 0.4),
                  child: Center(
                    child: _profil()
                  ),
                ),
                Column(
                  children: [
                    IsimContainer(w, h, isimcon),
                    EmailContainer(w, h, emailcon),
                    PasswordContainer(w, h, parolacon),
                    datetime == null ? GestureDetector(child: NullDateTime(h, w), onTap: Tarih) :
                      GestureDetector(child: DoluDateTime(h, w, datetime), onTap: Tarih),
                    GestureDetector(
                        child: LoginContainer(h, w),
                        onTap:(){kayitol(emailcon.text, parolacon.text, isimcon.text, datetime.toIso8601String());}),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Container LoginContainer(double h, double w) {
    return Container(
        height: h * 0.07,
        width: w * 0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xffbC6DE41)) ,
        child: Center(
          child: Text('SINGUP', style: TextStyle(fontSize: 30, color: Color(0xffb333533))),
        ));
  }
  Container PasswordContainer(double w, double h, TextEditingController parolacon) {
    return Container(
      width: w, height: h * 0.1,
      margin: EdgeInsets.all(10),
      child: TextFormField(
        validator: (name){if(name.isEmpty){return 'please enter your password';}},
        controller: parolacon,
        decoration: InputDecoration(
            fillColor: Color(0xffbC0C0C0),
            filled: true,
            labelText: 'Password',
            prefixIcon: Icon(Icons.vpn_key),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
            suffixIcon: parolacon.text.isEmpty ? Container(width: 0) : IconButton(icon: Icon(Icons.close),
                onPressed: () => parolacon.clear())
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      ),
    );
  }
  Container DoluDateTime(double h, double w, DateTime datetime) {
    return Container(
        width: w, height: h * 0.1,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)), color: Color(0xffbC0C0C0),
            border: Border.all(width: 3, color: Color(0xffb30475E))
        ) ,
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 10,),
              Icon(Icons.calendar_today, size: 20, color: Colors.black54,),
              SizedBox(width: 12,),
              Text(DateFormat.yMMMd().format(datetime), style: TextStyle(fontSize: 30, color: Colors.black87,)),
            ],
          ),
        ));
  }
  Container NullDateTime(double h, double w) {
    return Container(
        width: w, height: h * 0.1,
        margin: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)), color: Color(0xffbC0C0C0),
            border: Border.all(color:Color(0xff222831) , width: 4)),
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 10,),
              Icon(Icons.calendar_today, size: 20, color: Colors.black54,),
              SizedBox(width: 12,),
              Text('Doğum tarihi', style: TextStyle(fontSize: 20, color: Colors.black54,)),
            ],
          ),
        ));
  }
  Container EmailContainer(double w, double h, TextEditingController emailcon) {
    return Container(
      width: w, height: h * 0.1,
      margin: EdgeInsets.all(10),
      child: TextFormField(
        validator: (email) {if (email.isEmpty) {return 'please enter your email';}},
        controller: emailcon,
        decoration: InputDecoration(
            fillColor: Color(0xffbC0C0C0),
            filled: true,
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
            suffixIcon: emailcon.text.isEmpty
                ? Container(width: 0)
                : IconButton(
                icon: Icon(Icons.close), onPressed: () => emailcon.clear())
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      ),
    );
  }
  Container IsimContainer(double w, double h, TextEditingController isimcon) {
    return Container(
      width: w, height: h * 0.13,
      margin: EdgeInsets.all(10),
      child: TextFormField(
        validator: (name){if(name.isEmpty){return 'please enter your user name';}},
        controller: isimcon,
        maxLength: 20,
        decoration: InputDecoration(
            fillColor: Color(0xffbC0C0C0),
            filled: true,
            labelText: 'User Name',
            prefixIcon: Icon(Icons.account_circle),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
            suffixIcon: isimcon.text.isEmpty ? Container(width: 0) : IconButton(icon: Icon(Icons.close), onPressed: () => isimcon.clear())
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
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