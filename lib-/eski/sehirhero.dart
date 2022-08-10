import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_app/server.dart';
import 'package:flutter_app/binahero.dart';

class ItemHero extends StatelessWidget {
  @override
  final String ad;
  final String resim;
  final Color renk;
  final Color renk2;
  final String tarih;
  final double yildiz;
  final List<List> mesaj;
  final List<List> mekanlar;
  final String hava;
  final double sicaklik;
  final Function press;
  final double w;
  final double h;
  
  ItemHero({this.ad, this.resim, this.renk, this.renk2, this.tarih, this.yildiz, this.mesaj, this.mekanlar, this.hava, this.sicaklik, this.press, this.w, this.h});
  Widget build(BuildContext context) {

    Color siyah = Color(0xffb202020);
    Color aciksiyah = Color(0xffb333533);
    Color gri = Color(0xffbD6D6D6);
    Color aciksari = Color(0xffbFFEE32);
    Color sari = Color(0xffbFFD100);

    List<dynamic> anaMesaj = [];
    Widget mesajCont(){
      double x = 0;
      int y = 0;
      for(int i = 0; i < mesaj.length; i++){
        if(mesaj[i][2] > x){
          x = mesaj[i][2];
          y = i;
        }
      }
      anaMesaj = mesaj[y].sublist(0, 5);
      return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
          color: renk
        ),
        height: 120, width: w,
        child: Row(
          children: [
            SizedBox(width: 10,),
            SizedBox(
              height: 105, width: w * 0.1,
              child: Container(
                height: 100, width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: renk2, width: 2),
                    color: renk2.withOpacity(0.3)
                ),
                child: Center(
                  child: Text(anaMesaj[2].toString(), style: TextStyle(fontSize: 20),),
                ),
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(height: 110, width: w * 0.8, child: Text(anaMesaj[4], style: TextStyle(fontSize: 17),),),
          ],
        ),
      );
    }

    var mekancard = mekanlar.map((i) => Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(height: 120,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: i[4]
            ),
            child: Row(
              children: [
                SizedBox(width: w * 0.02,),
                Stack(
                  children: [
                    GestureDetector(
                      onTap: ()=> Navigator.push(context,
                          MaterialPageRoute(builder: (context)=> binaHero(
                            ad: i[0], resim: i[2], renk: i[4], renk2: i[5], tarih: i[7], yildiz: i[6],
                            press: () => Navigator.pop(context),w: w,))),
                      child: Container(
                        width: w * 0.37, height: w * 0.27,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(30)),
                            image: DecorationImage(image: AssetImage(i[2]), fit: BoxFit.cover)
                        ),
                      ),
                    ),
                    Container(
                      width: w * 0.15, height: w * 0.07,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                        color: i[4].withOpacity(0.7)
                      ),
                      child: Center(child: Text(i[6].toString())),
                    ),
                  ],
                ),
                SizedBox(width: 10,),
                SizedBox(width: w * 0.5, height: w * 0.2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(i[0], style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),),
                      SizedBox(height: 15,),
                      Row(
                        children: [
                          Icon(Icons.location_on),
                          Text(i[3], style: TextStyle(fontStyle: FontStyle.italic, fontSize: 17),),
                        ],
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
    )).toList();

    List<Widget> mesajlar = [];
    for(int i = 0; i < 5; i ++){
      mesajlar.add(Container(
        color: Colors.blueGrey,
        child: Column(
          children: [
            SizedBox(height: 5,),
            Row(
              children: [
                SizedBox(width: 10,),
                Container(
                  height: 40, width: 40,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: renk2, width: 2),
                      color: renk2.withOpacity(0.3)
                  ),
                  child: Center(
                    child: Text(mesaj[i][2].toString(), style: TextStyle(fontSize: 20),),
                  ),
                ),
                SizedBox(width: 10,),
                SizedBox(width: 40, child: ClipRRect(child: Image.asset(mesaj[i][0]), borderRadius: BorderRadius.circular(15),)),
                SizedBox(width: 10,),
                SizedBox(width: 90, child: Text(mesaj[i][1].toString(), style: TextStyle(fontSize: 20),)),
                SizedBox(width: 20,),
                Text(DateFormat.yMMMd().format(mesaj[i][3]), style: TextStyle(fontSize: 20),)
              ],
            ),
            SizedBox(height: 5,),
            SizedBox(height: 120, width: w * 0.85, child: Text(mesaj[i][4], style: TextStyle(fontSize: 17),),),
            SizedBox(height: 5,),
          ],
        ),
      ));
    }

    Widget Mesajcont(){
      return Container(
          width: w * 0.9,
          decoration: BoxDecoration(
              color: renk,
              borderRadius: BorderRadius.all(Radius.circular(20)),
              border: Border.all(width: 3, color: renk2)
          ),
          child: mesajCont()
      );
    }
    Widget Mesajlarcont(){
      return Container(
        decoration: BoxDecoration(
          color: aciksiyah,
          boxShadow: [
            BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(-5, -5),
                color: Colors.black),
            BoxShadow(
                spreadRadius: -4,
                blurRadius: 25,
                offset: Offset(7, 17),
                color: Colors.black
            )
          ],
        ),
        child: Column(
            children: [
              SizedBox(height: 10,),
              Text('Sehirdeki önemli tarihi yerleri',
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              ),
              //Container(color: Colors.transparent, margin: EdgeInsets.all(10), height: 200, child: ListWheelScrollView(children: mekancard, itemExtent: 120, diameterRatio: 2,),),
              SizedBox(
                height:  h * 0.8,
                child: SingleChildScrollView(child: Column(children: mesajlar,)),
              )
            ]
        ),
      );
    }
    Widget Sehirozet(){
      return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: renk,
          boxShadow: [
            BoxShadow(
                spreadRadius: -10,
                blurRadius: 17,
                offset: Offset(-5, -5),
                color: Colors.black),
            BoxShadow(
                spreadRadius: -4,
                blurRadius: 25,
                offset: Offset(7, 17),
                color: Colors.black
            )
          ],
        ),
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text('Sehir hakkında kısa bir bilgi',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            SizedBox(height: 10,),
            SizedBox(width: w * 0.85, child: Text(tarih)),
            SizedBox(height: 10,),
          ],
        ),
      );
    }
    Widget PuanMesaj(){
      return Column(
        children: [
          Container(
              height: 40, width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: renk2, width: 2),
                  color: renk2.withOpacity(0.6)
              ),
              child: Center(
                  child: Icon(Icons.message_rounded, size: 30, color: Colors.white70,)
              )
          ),
          SizedBox(height: 5),
          Container(
              height: 40, width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(color: renk2, width: 2),
                  color: renk2.withOpacity(0.6)
              ),
              child: Center(
                child: Text(yildiz.toString(), style: TextStyle(fontSize: 20, color: Colors.white70),),)
          ),
        ],
      );
    }
    Widget Hava(){
      return Row(
        children: [
          SizedBox(height: 45, width: 45, child: Image.asset(hava, fit: BoxFit.cover,)),
          SizedBox(width: 10,),
          Text(sicaklik.toString(), style: TextStyle(fontSize: 30),)
        ],
      );
    }
    Widget Mekankard(){
      return Container(
        child: Column(
          children: [
            SizedBox(height: 10,),
            Text('Sehirdeki önemli tarihi yerleri',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            ),
            //Container(color: Colors.transparent, margin: EdgeInsets.all(10), height: 200, child: ListWheelScrollView(children: mekancard, itemExtent: 120, diameterRatio: 2,),),
            SizedBox(
              height:  h * 0.6,
              child: SingleChildScrollView(child: Column(children: mekancard,)),
            )
          ]
        ),
      );
    }

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: renk.withOpacity(0.6),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
            ),
            elevation: 0,
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 35, color: Colors.black,), onPressed: press,),
            title: Text(ad, style: TextStyle(color: Colors.black, fontSize: 50),),
            actions: [
              IconButton(icon: Icon(Icons.favorite_border, color: Colors.red, size: 30,), onPressed: null)
            ],
          ),
          body: Container(
            width: w, height: h,
            decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover)
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  Stack(
                    children: [
                      Container(
                        width: w, height: h,
                      ),
                      Positioned(
                        bottom: 0,
                        child: Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Container(
                            width: w * 0.9,
                            decoration: BoxDecoration(
                                color: aciksiyah,
                                borderRadius: BorderRadius.all(Radius.circular(20)),
                            ),
                            child: Sehirozet(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Stack(
                    overflow: Overflow.visible,
                    children: [
                      Container(
                        width: w, height: h,
                      ),
                      Positioned(
                        left: -15, top: h * 0.1,
                        child: Container(
                          width: w,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.all(Radius.circular(20)),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: 160, width: w,
                                child: Stack(
                                  children: [
                                    Container(),
                                    Positioned(
                                      bottom: 0,
                                      child: Container(
                                        height: 120,
                                        decoration: BoxDecoration(
                                          borderRadius: BorderRadius.all(Radius.circular(30)),
                                          color: renk2
                                        ),
                                        child: mesajCont(),
                                      ),
                                    ),
                                    Center(
                                      heightFactor: 0.9,
                                      child: CircleAvatar(child: Icon(Icons.add), radius: 20, backgroundColor: renk,),
                                    )
                                  ],
                                ),
                              ),
                              Mekankard()
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          )
      ),
    );
  }
}
class sdhfsf extends StatelessWidget {
  @override
  final String ad;
  final String resim;
  final Color renk;
  final Color renk2;
  final String tarih;
  final double yildiz;
  final List<List> mesaj;
  final List<List> mekanlar;
  final String hava;
  final double sicaklik;
  final Function press;
  final double w;
  final double h;

  sdhfsf({this.ad, this.resim, this.renk, this.renk2, this.tarih, this.yildiz, this.mesaj, this.mekanlar, this.hava, this.sicaklik, this.press, this.w, this.h});
  Widget build(BuildContext context) {

    List<dynamic> anaMesaj = [];
    Widget mesajCont(){
      double x = 0;
      int y = 0;
      for(int i = 0; i < mesaj.length; i++){
        if(mesaj[i][2] > x){
          x = mesaj[i][2];
          y = i;
        }
      }
      anaMesaj = mesaj[y].sublist(0, 5);
      return Column(
        children: [
          SizedBox(height: 5,),
          Row(
            children: [
              SizedBox(width: 10,),
              Container(
                height: 40, width: 40,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: renk2, width: 2),
                    color: renk2.withOpacity(0.3)
                ),
                child: Center(
                  child: Text(anaMesaj[2].toString(), style: TextStyle(fontSize: 20),),
                ),
              ),
              SizedBox(width: 10,),
              SizedBox(width: 40, child: ClipRRect(child: Image.asset(anaMesaj[0]), borderRadius: BorderRadius.circular(15),)),
              SizedBox(width: 10,),
              SizedBox(width: 90, child: Text(anaMesaj[1].toString(), style: TextStyle(fontSize: 20),)),
              SizedBox(width: 20,),
              Text(DateFormat.yMMMd().format(anaMesaj[3]), style: TextStyle(fontSize: 20),)
            ],
          ),
          SizedBox(height: 5,),
          SizedBox(height: 120, width: w * 0.85, child: Text(anaMesaj[4], style: TextStyle(fontSize: 17),),),
          SizedBox(height: 5,),
        ],
      );
    }

    var mekancard = mekanlar.map((i) => Padding(
      padding: const EdgeInsets.all(4.0),
      child: Container(height: 120,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(30)),
            color: i[4]
        ),
        child: Row(
          children: [
            SizedBox(width: w * 0.02,),
            Stack(
              children: [
                GestureDetector(
                  onTap: ()=> Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> binaHero(
                        ad: i[0], resim: i[2], renk: i[4], renk2: i[5], tarih: i[7], yildiz: i[6],
                        press: () => Navigator.pop(context),w: w,))),
                  child: Container(
                    width: w * 0.37, height: w * 0.27,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(30)),
                        image: DecorationImage(image: AssetImage(i[2]), fit: BoxFit.cover)
                    ),
                  ),
                ),
                Container(
                  width: w * 0.15, height: w * 0.07,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(30), bottomRight: Radius.circular(30)),
                      color: i[4].withOpacity(0.7)
                  ),
                  child: Center(child: Text(i[6].toString())),
                ),
              ],
            ),
            SizedBox(width: 10,),
            SizedBox(width: w * 0.4, height: w * 0.2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(i[0], style: TextStyle(fontStyle: FontStyle.italic, fontSize: 25),),
                  SizedBox(height: 15,),
                  Row(
                    children: [
                      Icon(Icons.location_on),
                      Text(i[3], style: TextStyle(fontStyle: FontStyle.italic, fontSize: 17),),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    )).toList();

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Color(0xffb202020).withOpacity(0.6),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
            ),
            elevation: 0,
            leading: IconButton(icon: Icon(Icons.arrow_back, size: 35, color: Colors.black,), onPressed: press,),
            title: Text(ad, style: TextStyle(color: Colors.black, fontSize: 50),),
            actions: [
              IconButton(icon: Icon(Icons.favorite_border, color: Colors.red, size: 30,), onPressed: null)
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
                child: Column(
                  children: [
                    Container(width: w, height: w,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover)
                      ),
                    ),
                    Stack(
                        overflow: Overflow.visible,
                        children: [
                          Container(width: w, color: renk,
                            child: Column(
                              children: [
                                Container(
                                  width: w * 0.9,
                                  decoration: BoxDecoration(
                                      color: renk,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(width: 3, color: renk2)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text('Sehir hakkında kısa bir bilgi',
                                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                      ),
                                      SizedBox(height: 10,),
                                      SizedBox(width: w * 0.85, child: Text(tarih)),
                                      SizedBox(height: 10,),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                                Container(
                                    width: w * 0.9,
                                    decoration: BoxDecoration(
                                        color: renk,
                                        borderRadius: BorderRadius.all(Radius.circular(20)),
                                        border: Border.all(width: 3, color: renk2)
                                    ),
                                    child: mesajCont()
                                ),
                                SizedBox(height: 10,),
                                Container(
                                  width: w * 0.9,
                                  decoration: BoxDecoration(
                                      color: renk,
                                      borderRadius: BorderRadius.all(Radius.circular(20)),
                                      border: Border.all(width: 3, color: renk2)
                                  ),
                                  child: Column(
                                    children: [
                                      SizedBox(height: 10,),
                                      Text('Sehirdeki önemli tarihi yerleri',
                                        style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
                                      ),
                                      //Container(color: Colors.transparent, margin: EdgeInsets.all(10), height: 200, child: ListWheelScrollView(children: mekancard, itemExtent: 120, diameterRatio: 2,),),
                                      Column(children: mekancard,)
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10,),
                              ],
                            ),
                          ),
                          Positioned(
                            top: -20,
                            child: Container(height: 20, width: w,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(20),),
                                  color: renk
                              ),
                            ),
                          ),
                          Positioned(top: -110, right: 10,
                            child: Column(
                              children: [
                                Container(
                                    height: 40, width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: renk2, width: 2),
                                        color: renk2.withOpacity(0.6)
                                    ),
                                    child: Center(
                                        child: Icon(Icons.message_rounded, size: 30, color: Colors.white70,)
                                    )
                                ),
                                SizedBox(height: 5),
                                Container(
                                    height: 40, width: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        border: Border.all(color: renk2, width: 2),
                                        color: renk2.withOpacity(0.6)
                                    ),
                                    child: Center(
                                      child: Text(yildiz.toString(), style: TextStyle(fontSize: 20, color: Colors.white70),),)
                                ),
                              ],
                            ),
                          ),
                          Positioned(top: -220, left: 5,
                              child: Row(
                                children: [
                                  SizedBox(height: 45, width: 45, child: Image.asset(hava, fit: BoxFit.cover,)),
                                  SizedBox(width: 10,),
                                  Text(sicaklik.toString(), style: TextStyle(fontSize: 30),)
                                ],
                              )
                          ),
                        ]
                    )
                  ],
                )
            ),
          )
      ),
    );
  }
}
