import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'server.dart';

Color siya = Color(0xff222831);
Color beyaz = Color(0xffE8E8E8);
Color koyugri = Color(0xff333333);
Color gr = Color(0xffDDDDDD);
Color aciksiya = Color(0xff333533);
Color gir = Color(0xffD6D6D6);
Color kirmiz = Color(0xff990100);
Color yesi = Color(0xffC6DE41);
Color lacivert = Color(0xff30475E);
Color sar = Color(0xffFCA311);

class mesajSay extends StatefulWidget {
  List<dynamic> mesajlr;
  mesajSay(this.mesajlr);
  @override
  _mesajSayState createState() => _mesajSayState(mesajlr);
}
class _mesajSayState extends State<mesajSay> {
  List<dynamic> mesajlr;
  _mesajSayState(this.mesajlr);

  double puan = 8.5;
  final mesajcon = TextEditingController();

  @override
  void initState() {mesajcon.addListener(() => setState(() {}));}
  @override
  void dispose() {super.dispose();mesajcon.dispose();}

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double radius = 30;
    double margin = 10;
    double bosluk = 20;

    List<Widget> mesajlar = [];
    for(int i = 0; i < 2; i++)
      for(int i = 0; i < mesajlr.length; i++)
        mesajlar.add(Mesaj(size, margin, radius, bosluk, mesajlr[i]));

    return Scaffold(
      body: Stack(
        children: [
          Container(
            width: size.width, height: size.height, color: siya,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                SizedBox(height: size.height * 0.05,),
                Column(children: mesajlar,)
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: Container(width: size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(top: Radius.circular(radius / 2)),
                color: aciksiya.withOpacity(0.95),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: size.width * 0.2, height: 40,
                        margin: EdgeInsets.all(margin),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: lacivert
                        ),
                        child: Center(
                          child: Text(puan.toString(), style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: gr),),
                        ),
                      ),
                      Container(
                        height: 40,
                        margin: EdgeInsets.all(margin),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: lacivert
                        ),
                        child: SizedBox(
                            width: size.width * 0.68,
                            child: Center(
                              child: Slider(
                                min: 0.0,
                                max: 10,
                                divisions: 20,
                                activeColor: siya,
                                value: puan,
                                onChanged: (value){
                                  setState(() {
                                    puan = value;
                                  });
                                },
                              )
                            )
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(margin),
                        height: mesajcon.text.isEmpty? 40: size.height * 0.2,
                        width: size.width * 0.8,
                        padding: EdgeInsets.all(margin / 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(radius),
                            color: lacivert
                        ),
                        child: TextField(
                          controller: mesajcon,
                          maxLength: 300,
                          maxLines: 20,
                          decoration: InputDecoration(
                              hintStyle: TextStyle(
                                letterSpacing: 2,
                                color: gr,
                                fontWeight: FontWeight.bold,
                              ),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide.none
                              ),
                          ),
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.none,
                        ),
                      ),
                      Container(
                        width: 40,
                        child: Center(
                          child: GestureDetector(
                            onTap: (){
                              setState(() {
                                if(mesajcon.text.isNotEmpty)
                                  mesajlr.add(["Kullanıcı Mesajı", puan, DateTime.now(), mesajcon.text]);
                              });
                            },
                            child: CircleAvatar(
                              backgroundColor: sar,
                              radius: 33,
                              child: Center(
                                  child: Icon(Icons.send, size: 30, color: gir,)
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
  Container Mesaj(Size size, double margin, double radius, double bosluk, List favMesaj) {
    return Container(
        width: size.width * 0.95,
        margin: EdgeInsets.all(margin),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: lacivert,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: bosluk / 2,),
            Row(
              children: [
                SizedBox(width: bosluk,),
                Text(favMesaj[0] , style: TextStyle(fontSize: 25, color: gir),),
                Spacer(flex: 3,),
                Text("${favMesaj[2].year}-${favMesaj[2].month}-${favMesaj[2].day}", style: TextStyle(fontSize: 20, color: siya),),
                Spacer(),
              ],
            ),
            SizedBox(height: bosluk / 6,),
            Row(
              children: [
                SizedBox(width: bosluk * 2,),
                Text(favMesaj[1].toString() , style: TextStyle(fontSize: 20, color: sar),),
              ],
            ),
            SizedBox(height: bosluk / 4,),
            Row(
              children: [
                SizedBox(width: bosluk,),
                SizedBox(
                    width: size.width * 0.85,
                    child: Text(favMesaj[3] , style: TextStyle(fontSize: 18, color: gir),)
                ),
              ],
            ),
            SizedBox(height: bosluk / 2,),
          ],
        )
    );
  }
}