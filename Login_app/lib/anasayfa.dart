import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:login_app/StatusServis.dart';
import 'package:provider/provider.dart';
import 'profilprovider.dart';

class SingUpPage extends StatefulWidget {
  @override
  _SingUpPageState createState() => _SingUpPageState();
}
class _SingUpPageState extends State<SingUpPage> {
  final isimcon = TextEditingController();
  final emailcon = TextEditingController();
  final parolacon = TextEditingController();
  final genelcon = GlobalKey<FormState>();
  DateTime datetime;

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
  kayit(String email, String parola, String isim, String datetime, String uid){
    String name = Provider.of<CostumProfilData>(context, listen: false).name;
    String mail = Provider.of<CostumProfilData>(context, listen: false).email;
    String password = Provider.of<CostumProfilData>(context, listen: false).password;
    String id = Provider.of<CostumProfilData>(context, listen: false).id;
    String date = Provider.of<CostumProfilData>(context, listen: false).date;

    Provider.of<CostumProfilData>(context, listen: false)
        .setProfiData({name : isim, password : parola, mail : email, id : uid, date : datetime});

    print("profil : ${Provider.of<CostumProfilData>(context, listen: false).getProfilData}");
  }

  StatusServis sService = StatusServis();

  @override
  Widget build(BuildContext context) {
    print(Provider.of<CostumProfilData>(context).getProfilData);

    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

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
      List<int> imageBytes = profilimage.readAsBytesSync();
      print(imageBytes);
      String base64Image = base64Encode(imageBytes);
      return base64Image;
    }

    return Form(
      key: genelcon,
      child: SingleChildScrollView(
        child: Container(
          width: w, height: h * 1.05, color: Color(0xff30475E),
          child: Column(
            children: [
              Spacer(),
              Column(
                children: [
                  IsimContainer(w, h, isimcon),
                  EmailContainer(w, h, emailcon),
                  PasswordContainer(w, h, parolacon),
                  datetime == null ? GestureDetector(child: NullDateTime(h, w), onTap: Tarih) :
                  GestureDetector(child: DoluDateTime(h, w, datetime), onTap: Tarih),
                  Test(w, h, Provider.of<CostumProfilData>(context).getProfilData),
                  GestureDetector(
                      child: LoginContainer(h, w),
                      onTap: (){(kayitol(emailcon.text, parolacon.text, isimcon.text, datetime.toIso8601String()));}
                  ),
                ],
              ),
              Spacer(),
            ],
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
          child: Text('SIGNUP', style: TextStyle(fontSize: 30, color: Color(0xffb333533))),
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
              Text(datetime.toString(), style: TextStyle(fontSize: 10, color: Colors.black87,)),
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
  Container Test(double w, double h, Map<String, dynamic> profil) {
    String name = Provider.of<CostumProfilData>(context, listen: false).name;
    String email = Provider.of<CostumProfilData>(context, listen: false).email;
    String password = Provider.of<CostumProfilData>(context, listen: false).password;
    String id = Provider.of<CostumProfilData>(context, listen: false).id;
    String date = Provider.of<CostumProfilData>(context, listen: false).date;
    return Container(
      width: w, height: h * 0.13,
      margin: EdgeInsets.all(10),
      child: Text(
        "${profil[name]}, ${profil[password]}, ${profil[email]}, ${profil[date]}, ${profil[id]}"
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