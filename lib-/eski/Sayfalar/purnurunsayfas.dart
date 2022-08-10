import 'package:flutter/material.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/server.dart';
import 'dart:core';
import 'package:flutter_app/init/local_keys.g.dart';
import 'package:flutter_app/init/string_ext.dart';
import 'package:flutter_app/init/theme.dart';
import 'main.dart';

class Panasayfa extends StatefulWidget {
  String ad;
  Panasayfa(this.ad);
  @override
  _panasayfaState createState() => _panasayfaState(ad);
}
class _panasayfaState extends State<Panasayfa> {
  String ad;
  _panasayfaState(this.ad);

  bool dark = true;

  @override
  final genelcon = GlobalKey<FormState>();

  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  Map<String, IconData> eveticon = {
    'baslangic' : Icons.flight_takeoff,
    'gezi' : Icons.account_balance_rounded,
    'bitis' : Icons.flight_land,
  };

  List<dynamic> aktiveEvent = ['Ayasofya ziyareti', '14.30', 'gezi', 'ayasofya'];

  Map<DateTime, List<dynamic>> events = {
    DateTime(2021, 8, 23) : [['i', '10.30', 'baslangic'], ['2', '12.30', 'gezi'] ,['3', '14.30', 'gezi'],],
    DateTime(2021, 8, 24) : [['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
    DateTime(2021, 8, 25) : [['i', '10.30', 'baslangic'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
    DateTime(2021, 8, 26) : [['i', '10.30', 'baslangic'], ['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'],['7', '22.00', 'bitis']],
    DateTime(2021, 8, 27) : [['2', '12.30', 'gezi'] ,['3', '14.30', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
    DateTime(2021, 8, 28) : [['i', '10.30', 'baslangic'],['3', '14.30', 'gezi'], ['5', '17.00', 'gezi'], ['7', '22.00', 'bitis']],
    DateTime(2021, 8, 29) : [['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
  };
  List<dynamic> selectevent = [['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis'],];
  int g = DateTime.now().weekday - 1;

  void bidirim(){
    if(genelcon.currentState.validate()){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context){
            return AlertDialog(
              title: Text(MekanMap[aktiveEvent[3]]['ad'], textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
              content: SingleChildScrollView(
                child: Text(MekanMap[aktiveEvent[3]]['tarih']),
              ),
              actions: [
                FlatButton(onPressed:() {setState(() {Navigator.pop(context);});},
                    child: Text('Tamam'))
              ],
            );
          }
      );
    }
  }

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<String> ay = [localKeys.takvim_oca.locale, localKeys.takvim_sub.locale, localKeys.takvim_mar.locale,
      localKeys.takvim_nis.locale, localKeys.takvim_may.locale, localKeys.takvim_haz.locale, localKeys.takvim_tem.locale,
      localKeys.takvim_agu.locale, localKeys.takvim_eyl.locale, localKeys.takvim_eki.locale, localKeys.takvim_kas.locale,
      localKeys.takvim_ara.locale];

    Widget guncard(int i, String gun){
      if(i == g){
        return Container(
          height: 100, width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
              color: theme().renk(theme().Siyah, dark)
          ),
          child: Center(
            child: RotatedBox(quarterTurns: -1,
                child: Text(gun,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme().renk(theme().Gri, dark)),
                )
            ),
          ),
        );
      }
      else{
        return Container(
          height: 60, width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: theme().renk(theme().Siyah, dark)
          ),
          child: Center(
            child: RotatedBox(quarterTurns: -1,
                child: Text(gun,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme().renk(theme().Gri, dark)),
                )
            ),
          ),
        );
      }
    }

    List<Widget> eventlist = [];
    for(int i = 0; i < 3; i ++)
      eventlist.add(Container(
          width: size.width * 0.7, height: 80,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme().renk(theme().aciksiyah, dark), width: 3)
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              SizedBox(
                width: size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text(selectevent[i][1], style: TextStyle(color: theme().renk(theme().Gri, dark), fontSize: 20),),
                    SizedBox(height: 10,),
                    Text(selectevent[i][0], style: TextStyle(color: theme().renk(theme().Gri, dark), fontSize: 20),),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme().renk(theme().aciksiyah, dark), width: 3),
                    color: theme().renk(theme().Gri, dark),
                  ),
                  child: Center(child: Icon(eveticon[selectevent[i][2]], size: 30, color: theme().renk(theme().aciksiyah, dark),))
              )
            ],
          )
      ),);
    Widget gunlukPlan(){

      return Container(
        height: 490, width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(40),),
          color: theme().renk(theme().Siyah, dark),
          boxShadow: [
            BoxShadow(
                spreadRadius: -10,
                blurRadius: 12,
                offset: Offset(-5, -3),
                color: dark ?  Colors.black : Colors.white
            ), BoxShadow(
                spreadRadius: -4,
                blurRadius: 12,
                offset: Offset(5, 5),
                color: dark ?  Colors.black : Colors.white
            )
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
              children: eventlist
          ),
        ),
      );
    }

    void initState() {
      super.initState();
      events = {};
      selectevent = [];
      g = DateTime.now().weekday;
    }

    return Form(
      key: genelcon,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: size.width, height: size.height * 1.4, color: Colors.black,),
            Container(
              width: size.width, height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/ekran3.PNG'), fit: BoxFit.cover),
              ),
            ),
            Container(
              width: size.width, height: size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                    stops: <double>[0.5, 0.95],
                  )
              ),
            ),
            Merhaba(ad),
            Anlikharaket(size),
            Tarih(ay),
            Positioned(bottom: 90, left: 60, child: gunlukPlan()),
            GulukHareketler(size, guncard),
          ],
        ),
      ),
    );
  }

  Positioned Tarih(List<String> ay) {
    return Positioned(bottom: 600, left: 30,
          child: RichText(
            text: TextSpan(
                children: <TextSpan>[
                  TextSpan(text: '${ay[DateTime.now().month - 1]}',
                    style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.lightBlue,),),
                  TextSpan(text: ' , ', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                  TextSpan(text: '${DateTime.now().year}',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xffa5e65a)),),
                ]
            ),
          )
      );
  }
  Positioned GulukHareketler(Size size, Widget guncard(int i, String gun)) {
    return Positioned(bottom: 90, left: 4,
        child: Column(
          children: [
            SizedBox(height: size.height * 0.08,),
            GestureDetector(
              child: guncard(0, localKeys.takvim_pzt.locale),
              onTap: (){setState(() {g = 0;selectevent = events[DateTime(2021, 8, 23)];});},
            ),
            SizedBox(height: 5,),
            GestureDetector(
              child: guncard(1, localKeys.takvim_sal.locale),
              onTap: (){setState(() {g = 1;selectevent = events[DateTime(2021, 8, 24)];});},
            ),
            SizedBox(height: 5,),
            GestureDetector(
              child: guncard(2, localKeys.takvim_car.locale),
              onTap: (){setState(() {g = 2;selectevent = events[DateTime(2021, 8, 25)];});},
            ),
            SizedBox(height: 5,),
            GestureDetector(
              child: guncard(3, localKeys.takvim_per.locale),
              onTap: (){setState(() {g = 3;selectevent = events[DateTime(2021, 8, 26)];});},
            ),
            SizedBox(height: 5,),
            GestureDetector(
              child: guncard(4, localKeys.takvim_cum.locale),
              onTap: (){setState(() {g = 4;selectevent = events[DateTime(2021, 8, 27)];});},
            ),
            SizedBox(height: 5,),
            GestureDetector(
              child: guncard(5, localKeys.takvim_cmt.locale),
              onTap: (){setState(() {g = 5;selectevent = events[DateTime(2021, 8, 28)];});},
            ),
            SizedBox(height: 5,),
            GestureDetector(
              child: guncard(6, localKeys.takvim_paz.locale),
              onTap: (){setState(() {g = 6;selectevent = events[DateTime(2021, 8, 29)];});},
            ),
          ],
        ),
      );
  }
  Positioned Anlikharaket(Size size) {
    return Positioned(top: 190, left: 30,
            child: Container(
                width: size.width * 0.85, height: 100,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme().renk(theme().Siyah, dark), width: 3),
                    color: theme().renk(theme().aciksiyah, dark)
                ),
                child: Row(
                  children: [
                    SizedBox(width: 5),
                    SizedBox(
                      width: size.width * 0.45,
                      child: Center(child: Text(aktiveEvent[0], style: TextStyle(color: theme().renk(theme().Gri, dark), fontSize: 25),textAlign: TextAlign.center,),)
                    ),
                    Container(
                      margin: EdgeInsets.all(5),
                      width: 90,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(color: theme().renk(theme().Siyah, dark), width: 3),
                        image: DecorationImage(image: AssetImage(MekanMap[aktiveEvent[3]]['resim']), fit: BoxFit.cover),
                      ),
                    ),
                    SizedBox(width: 5),
                    GestureDetector(
                      child: Container(
                        width: 40, height: 100,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            color: theme().renk(theme().Gri, dark).withOpacity(0.8)
                        ),
                        child: Center(child: Icon(Icons.info_outline, size: 40, color: theme().renk(theme().aciksiyah, dark),)
                        ),
                      ),
                        onTap: (){bidirim();}
                    )
                  ],
                )
            ),
          );
  }
  Positioned Merhaba(String ad) {
    return Positioned(top: 130, left: 30,
              child: Text('${localKeys.anaSayfa_merhaba.locale},${ad}',
                style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),)
          );
  }
}
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xffb333533);
    Path path = Path()
      ..relativeLineTo(0, 90)
      ..quadraticBezierTo(size.width / 2, 170, size.width, 90)
      ..relativeLineTo(0, -90)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}