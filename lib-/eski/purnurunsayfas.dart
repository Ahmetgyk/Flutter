import 'package:flutter/material.dart';
import 'package:flutter_app/anaSayfa.dart';
import 'package:flutter_app/server.dart';
import 'package:flutter/scheduler.dart';
import 'dart:core';
import 'package:flutter_app/binahero.dart';
import 'package:flutter_app/server.dart';

class Panasayfa extends StatefulWidget {
  @override
  _panasayfaState createState() => _panasayfaState();
}
class _panasayfaState extends State<Panasayfa> {
  @override

  Color siyah = Color(0xffb202020);
  Color aciksiyah = Color(0xffb333533);
  Color gri = Color(0xffbD6D6D6);
  Color aciksari = Color(0xffbFFEE32);
  Color sari = Color(0xffbFFD100);

  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  List<String> hafta = ['Pzt', 'Sal',  'Çar', 'Per', 'Cum','Crt', 'Paz',];
  List<String> ay = ['ocak', 'şubat', 'mart', 'nısan', 'mayıs', 'haziran', 'temmuz', 'Ağu', 'eylül', 'ekim', 'kasım', 'aralık',];

  Map<String, IconData> eveticon = {
    'baslangic' : Icons.flight_takeoff,
    'gezi' : Icons.account_balance_rounded,
    'bitis' : Icons.flight_land,
  };

  _profil(){
    if(profil['resim'] == null)
      return Container(
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: siyah, width: 5)
        ),
        child: Icon(Icons.account_circle, color: Colors.grey, size: 60,)
      );
    else
      return Container(
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: FileImage(profil['resim']), fit: BoxFit.cover),
              border: Border.all(color: siyah, width: 5)
          ),
      );
  }

  Map<DateTime, List<dynamic>> events;
  List<dynamic> selectevent = [
    ['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis'],
  ];
  int g = DateTime.now().weekday - 1;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool thema = true;

    List<String> haftagun = ['Pzt', 'Sal',  'Çar', 'Per', 'Cum','Crt', 'Paz'];
    Function haftaolusturma(){
      int a = date.weekday - 1;
      for(int i = 0; i < a; i ++)
        haftagun.add(hafta[DateTime(date.year, date.month, date.day - (a - i)).weekday- 1 ]);
      haftagun.add('bugün');
      for(int n = 1; n < (7 - a); n ++)
        haftagun.add(hafta[DateTime(date.year, date.month, date.day + n).weekday- 1 ]);
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {haftaolusturma();});

    void initState() {
      super.initState();
      events = {};
      selectevent = [];
      g = DateTime.now().weekday;
    }

    events = {
      DateTime(2021, 8, 23) : [['i', '10.30', 'baslangic'], ['2', '12.30', 'gezi'] ,['3', '14.30', 'gezi'],],
      DateTime(2021, 8, 24) : [['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
      DateTime(2021, 8, 25) : [['i', '10.30', 'baslangic'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
      DateTime(2021, 8, 26) : [['i', '10.30', 'baslangic'], ['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'],['7', '22.00', 'bitis']],
      DateTime(2021, 8, 27) : [['2', '12.30', 'gezi'] ,['3', '14.30', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
      DateTime(2021, 8, 28) : [['i', '10.30', 'baslangic'],['3', '14.30', 'gezi'], ['5', '17.00', 'gezi'], ['7', '22.00', 'bitis']],
      DateTime(2021, 8, 29) : [['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
    };

    Widget guncard(int i){
      if(i == g){
        return Container(
          height: 100, width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
              color: siyah
          ),
          child: Center(
            child: RotatedBox(quarterTurns: -1,
                child: Text(haftagun[i],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
              color: siyah
          ),
          child: Center(
            child: RotatedBox(quarterTurns: -1,
                child: Text(haftagun[i],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                )
            ),
          ),
        );
      }
    }

    List<Widget> eventlist = [];
    for(int i = 0; i < selectevent.length; i ++)
      eventlist.add(Container(
          width: size.width * 0.7, height: 80,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: aciksiyah, width: 3)
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
                    Text(selectevent[i][1], style: TextStyle(color: Colors.white, fontSize: 20),),
                    SizedBox(height: 10,),
                    Text(selectevent[i][0], style: TextStyle(color: Colors.white, fontSize: 20),),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.all(5),
                  width: size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: aciksiyah, width: 3),
                  color: gri,
                ),
                child: Center(child: Icon(eveticon[selectevent[i][2]], size: 30,))
              )
            ],
          )
      ),);
    Widget gunlukPlan(){
      return Container(
        height: 490, width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(40),),
          color: siyah,
          boxShadow: [
            BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(-5, -5),
                color: Colors.black
            ), BoxShadow(
                spreadRadius: -4,
                blurRadius: 25,
                offset: Offset(7, 17),
                color: Colors.black
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

    return Stack(
      children: [
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
        Positioned(top: 100, left: 30,
            child: Text('Merhaba, ${profil['ad']}', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),)
        ),
        Positioned(bottom: 90, left: 60,
            child: gunlukPlan()
        ),
        Positioned(bottom: 90, left: 4,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.08,),
              GestureDetector(
                child: guncard(0),
                onTap: (){setState(() {g = 0;selectevent = events[DateTime(2021, 8, 23)];});},
              ),
              SizedBox(height: 5,),
              GestureDetector(
                child: guncard(1),
                onTap: (){setState(() {g = 1;selectevent = events[DateTime(2021, 8, 24)];});},
              ),
              SizedBox(height: 5,),
              GestureDetector(
                child: guncard(2),
                onTap: (){setState(() {g = 2;selectevent = events[DateTime(2021, 8, 25)];});},
              ),
              SizedBox(height: 5,),
              GestureDetector(
                child: guncard(3),
                onTap: (){setState(() {g = 3;selectevent = events[DateTime(2021, 8, 26)];});},
              ),
              SizedBox(height: 5,),
              GestureDetector(
                child: guncard(4),
                onTap: (){setState(() {g = 4;selectevent = events[DateTime(2021, 8, 27)];});},
              ),
              SizedBox(height: 5,),
              GestureDetector(
                child: guncard(5),
                onTap: (){setState(() {g = 5;selectevent = events[DateTime(2021, 8, 28)];});},
              ),
              SizedBox(height: 5,),
              GestureDetector(
                child: guncard(6),
                onTap: (){setState(() {g = 6;selectevent = events[DateTime(2021, 8, 29)];});},
              ),
            ],
          ),
        ),
      ],
    );
  }
}
class sds extends StatefulWidget {
  @override
  _sdsState createState() => _sdsState();
}
class _sdsState extends State<sds> {
  @override
  Color siyah = Color(0xffb202020);
  Color aciksiyah = Color(0xffb333533);
  Color gri = Color(0xffbD6D6D6);
  Color aciksari = Color(0xffbFFEE32);
  Color sari = Color(0xffbFFD100);

  DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

  List<String> hafta = ['Pzt', 'Sal',  'Çar', 'Per', 'Cum','Crt', 'Paz',];
  List<String> ay = ['ocak', 'şubat', 'mart', 'nısan', 'mayıs', 'haziran', 'temmuz', 'Ağu', 'eylül', 'ekim', 'kasım', 'aralık',];

  Map<String, IconData> eveticon = {
    'baslangic' : Icons.flight_takeoff,
    'gezi' : Icons.account_balance_rounded,
    'bitis' : Icons.flight_land,
  };

  _profil(){
    if(profil['resim'] == null)
      return Container(
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: siyah, width: 5)
          ),
          child: Icon(Icons.account_circle, color: Colors.grey, size: 60,)
      );
    else
      return Container(
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: FileImage(profil['resim']), fit: BoxFit.cover),
            border: Border.all(color: siyah, width: 5)
        ),
      );
  }

  Map<DateTime, List<dynamic>> events;
  List<dynamic> selectevent;
  int g = DateTime.now().weekday - 1;

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool thema = true;

    List<String> haftagun = ['Pzt', 'Sal',  'Çar', 'Per', 'Cum','Crt', 'Paz'];
    Function haftaolusturma(){
      int a = date.weekday - 1;
      for(int i = 0; i < a; i ++)
        haftagun.add(hafta[DateTime(date.year, date.month, date.day - (a - i)).weekday- 1 ]);
      haftagun.add('bugün');
      for(int n = 1; n < (7 - a); n ++)
        haftagun.add(hafta[DateTime(date.year, date.month, date.day + n).weekday- 1 ]);
    }
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {haftaolusturma();});

    void initState() {
      super.initState();
      events = {};
      selectevent = [];
      g = DateTime.now().weekday;
    }

    selectevent = [
      ['i', '10.30', 'baslangic'], ['2', '12.30', 'gezi'] ,['3', '14.30', 'gezi'],
      ['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis'],
    ];

    Widget guncard(int i){
      if(i == g){
        return Container(
          height: 100, width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
              color: siyah
          ),
          child: Center(
            child: RotatedBox(quarterTurns: -1,
                child: Text(haftagun[i],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
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
              color: siyah
          ),
          child: Center(
            child: RotatedBox(quarterTurns: -1,
                child: Text(haftagun[i],
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white),
                )
            ),
          ),
        );
      }
    }

    List<Widget> eventlist = [];
    for(int i = 0; i < selectevent.length; i ++)
      eventlist.add(Container(
          width: size.width * 0.7, height: 80,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: aciksiyah, width: 3)
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
                    Text(selectevent[i][1], style: TextStyle(color: Colors.white, fontSize: 20),),
                    SizedBox(height: 10,),
                    Text(selectevent[i][0], style: TextStyle(color: Colors.white, fontSize: 20),),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: aciksiyah, width: 3),
                    color: gri,
                  ),
                  child: Center(child: Icon(eveticon[selectevent[i][2]], size: 30,))
              )
            ],
          )
      ),);
    Widget gunlukPlan(){
      return Container(
        height: 490, width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(40),),
          color: siyah,
          boxShadow: [
            BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(-5, -5),
                color: Colors.black
            ), BoxShadow(
                spreadRadius: -4,
                blurRadius: 25,
                offset: Offset(7, 17),
                color: Colors.black
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

    return SingleChildScrollView(
      child: Column(
        children: [
          Stack(
            children: [
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
            ],
          ),
          Container(
            height: 390,
            child: Stack(
              overflow: Overflow.visible,
              children: [
                Container(
                  width: size.width, height: size.height,
                  decoration: BoxDecoration(
                      color: Colors.black
                  ),
                ),
                Positioned(top: -510, left: 40,
                  child: Stack(
                    overflow: Overflow.visible,
                    children: [
                      GestureDetector(
                        child: Container(
                          height: 160, width: size.width * 0.8,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: aciksiyah,
                            boxShadow: [
                              BoxShadow(
                                  spreadRadius: -4,
                                  blurRadius: 25,
                                  offset: Offset(7, 17),
                                  color: Colors.black
                              )
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text('Yer hakkında bilgi edinmek için', style: TextStyle(fontSize: 20, color: gri),),
                              SizedBox(height: 10,),
                            ],
                          ),
                        ),
                        onTap: ()=> Navigator.push(context,
                            MaterialPageRoute(builder: (context)=> binaHero(
                              ad: galatakul['ad'], resim: galatakul['resim'], renk: galatakul['renk1'],
                              renk2: galatakul['renk2'], tarih: galatakul['tarih'], yildiz: galatakul['puan'],
                              press: () => Navigator.pop(context),w: size.width,))),
                      ),
                      Container(
                        height: 120, width: size.width * 0.8,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: siyah,
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: -10,
                                blurRadius: 17,
                                offset: Offset(-5, -5),
                                color: Colors.black),
                          ],
                        ),
                        child: Row(
                          children: [
                            SizedBox(width: 10,),
                            SizedBox(
                              width: size.width * 0.55,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 30,),
                                  Text('10:30', style: TextStyle(color: Colors.white, fontSize: 20),),
                                  SizedBox(height: 10,),
                                  Text('Kapadokya ziyareti', style: TextStyle(color: Colors.white, fontSize: 20),),
                                ],
                              ),
                            ),
                            SizedBox(height: 10,),
                            SizedBox(
                              width: 80,
                              child: Container(
                                width: 80, height: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    image: DecorationImage(image: AssetImage('assets/images/galatakul2.jpg'), fit: BoxFit.cover),
                                    border: Border.all(color: aciksiyah, width: 5)
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(top: -550, left: 60,
                    child: Text('Merhaba, Ahmet', style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),)
                ),
                Positioned(top: -192, left: size.width * 0.15,
                    child: gunlukPlan()
                ),
                Positioned(top: -270, left: 20,
                  child: RichText(
                    text: TextSpan(
                        children: <TextSpan>[
                          TextSpan(text: ay[date.month - 1], style: TextStyle(color: Colors.lightBlue, fontSize: 60,)),
                          TextSpan(text: ',', style: TextStyle(color: Colors.lightBlue, fontSize: 40,)),
                          TextSpan(text: date.year.toString(), style: TextStyle(color: Color(0xffa5e65a), fontSize: 45)),
                        ]
                    ),
                  ),
                ),
                Positioned(top: -250, left: 4,
                  child: Column(
                    children: [
                      SizedBox(height: size.height * 0.08,),
                      GestureDetector(
                        child: guncard(0),
                        onTap: (){setState(() {g = 0;});},
                      ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        child: guncard(1),
                        onTap: (){setState(() {g = 1;});},
                      ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        child: guncard(2),
                        onTap: (){setState(() {g = 2;});},
                      ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        child: guncard(3),
                        onTap: (){setState(() {g = 3;});},
                      ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        child: guncard(4),
                        onTap: (){setState(() {g = 4;});},
                      ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        child: guncard(5),
                        onTap: (){setState(() {g = 5;});},
                      ),
                      SizedBox(height: 5,),
                      GestureDetector(
                        child: guncard(6),
                        onTap: (){setState(() {g = 6;});},
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
