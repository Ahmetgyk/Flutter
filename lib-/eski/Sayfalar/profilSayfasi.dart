import 'dart:math';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/init/local_keys.g.dart';
import 'package:flutter_app/init/string_ext.dart';
import 'package:flutter_app/init/theme.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/server.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/utils.dart';
import 'dart:io';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: profilePage(),
    );
  }
}

class profilePage extends StatefulWidget {
  @override
  _State createState() => _State();
}
class _State extends State<profilePage> {
  final emailcon = TextEditingController();
  final isimcon = TextEditingController();
  final genelcon = GlobalKey<FormState>();
  DateTime datetime = DateTime.now();

  bool dark = true;

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
    _profil(){
    //Provide.['resim'] == null &&
    if(profilimage == null)
        return  CircleAvatar(
            backgroundColor: theme().renk(theme().Siyah, dark), radius: MediaQuery.of(context).size.width * 0.25,
            child: Icon(Icons.account_circle, size: MediaQuery.of(context).size.width * 0.5, color: Color(0xffbC0C0C0),
            )
        );
      //&& profil['resim'] != null
      if(profilimage == null )
        return Container(
        padding: EdgeInsets.all(10.0),
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        decoration: BoxDecoration(
          border: Border.all(color: theme().renk(theme().Siyah, dark), width: 10),
          shape: BoxShape.circle,
          color: theme().renk(theme().aciksiyah, dark),
          image: DecorationImage(
            fit: BoxFit.cover,
            //image: FileImage(profil['resim']),
          ),
        ),
      );
      if(profilimage != null)
        return Container(
          padding: EdgeInsets.all(10.0),
          width: MediaQuery.of(context).size.width / 2,
          height: MediaQuery.of(context).size.width / 2,
          decoration: BoxDecoration(
            border: Border.all(color: theme().renk(theme().Siyah, dark), width: 10),
            shape: BoxShape.circle,
            color: theme().renk(theme().aciksiyah, dark),
            image: DecorationImage(
              fit: BoxFit.cover,
              image: FileImage(profilimage),
            ),
          ),
        );
    }

    return Scaffold(
      backgroundColor: theme().renk(theme().Siyah, dark),
      appBar: AppBarMethod(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 80,
          child: Stack(
            children: [
              CustomPaint(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                ),
                painter: HeaderCurvedContainer(),
              ),
              Positioned(top: 20, left: 0, child: _profil(),),
              Isim(context),
              Profil(context),
              Container(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      height: 450,
                      width: double.infinity,
                      margin: EdgeInsets.symmetric(horizontal: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          SizedBox(height: 40,),
                          IsimDegistirme(),
                          MailDegistirme(),
                          DogumTarihiDegistirme(context)
                        ],
                      ),
                    ),
                    Guncelleme(context),
                    SizedBox(height: 20,)
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Container Guncelleme(BuildContext context) {
    return Container(
                    height: 55,
                    width: double.infinity,
                    child: GestureDetector(
                        child: Container(
                            height: MediaQuery.of(context).size.height*0.07,
                            width: MediaQuery.of(context).size.width*0.8,
                            decoration: BoxDecoration(borderRadius:
                            BorderRadius.all(Radius.circular(20)), color: theme().renk(theme().Gri, dark)) ,
                            child: Center(
                              child: Text(localKeys.profilsayfa_guncelle.locale, style: TextStyle(fontSize: 30,)),
                            )),
                      onTap: (){
                          setState(() {
                            //profil['resim'] = profilimage;
                            //profil['ad'] = isimcon.text;
                           // profil['email'] = emailcon.text;
                           // profil['dogutarihi'] = datetime;
                          });
                      },
                    ),
                  );
  }
  Material DogumTarihiDegistirme(BuildContext context) {
    return Material(
                          elevation: 4,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: GestureDetector(
                              child: Container(
                                  height: MediaQuery.of(context).size.height*0.08,
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
                        );
  }
  Material MailDegistirme() {
    return Material(
                          elevation: 4,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: emailcon,
                            decoration: InputDecoration(
                                //hintText: profil['email'],
                                prefixIcon: Icon(Icons.email_outlined),
                                hintStyle: TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                                fillColor: Colors.white,
                                filled: false,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none
                                ),
                                suffixIcon: emailcon.text.isEmpty ? Container(width: 0) : IconButton(icon: Icon(Icons.close), onPressed: () => isimcon.clear())
                            ),
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.none,
                          ),
                        );
  }
  Material IsimDegistirme() {
    return Material(
                          elevation: 6,
                          shadowColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: TextFormField(
                            controller: isimcon,
                            maxLength: 20,
                            decoration: InputDecoration(
                                //hintText: profil['ad'],
                                prefixIcon: Icon(Icons.account_circle_rounded),
                                hintStyle: TextStyle(
                                  letterSpacing: 2,
                                  color: Colors.black54,
                                  fontWeight: FontWeight.bold,
                                ),
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: BorderSide.none
                                ),
                                suffixIcon: isimcon.text.isEmpty ? Container(width: 0) : IconButton(icon: Icon(Icons.close), onPressed: () => isimcon.clear())
                            ),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.none,
                          ),
                        );
  }
  Positioned Profil(BuildContext context) {
    return Positioned(
                top: 160, left: 160,
                child: CircleAvatar(
                  backgroundColor: Colors.black54,
                  child: IconButton(
                    icon: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onPressed: () {showcamgal(context);},
                  ),
                ),
            );
  }
  Positioned Isim(BuildContext context) {
    return Positioned(
              top: 30, right: 5,
              child: SizedBox(
                width: MediaQuery.of(context).size.width / 2,
                child: Text(
                  "profil['ad']",
                  style: TextStyle(
                    fontSize: 35,
                    letterSpacing: 1.5,
                    color: theme().renk(theme().Gri, dark),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              )
            );
  }
  AppBar AppBarMethod(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: theme().renk(theme().aciksiyah, dark),
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back,
          color: Colors.white,
        ),
        onPressed: (){Navigator.pop(context);},
      ),
    );
  }
}
class HeaderCurvedContainer extends CustomPainter {
  bool dark = true;

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = theme().renk(theme().aciksiyah, dark);
    Path path = Path()
      ..relativeLineTo(0, 60)
      ..quadraticBezierTo(size.width / 2, 150, size.width, 60)
      ..relativeLineTo(0, -60)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}