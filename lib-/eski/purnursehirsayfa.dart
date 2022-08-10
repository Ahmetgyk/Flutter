import 'package:flutter/material.dart';
import 'package:flutter_app/purnurunsayfas.dart';
import 'package:flutter_app/server.dart';
import 'package:flutter_app/takvimden.dart';
import 'sehirhero.dart';
import 'dart:math';

class pSehirSayfa extends StatefulWidget {
  @override
  _sehirsayfaState createState() => _sehirsayfaState();
}
class _sehirsayfaState extends State<pSehirSayfa> {
  final isimcon = TextEditingController();

  Color siyah = Color(0xffb202020);
  Color aciksiyah = Color(0xffb333533);
  Color gri = Color(0xffbD6D6D6);
  Color aciksari = Color(0xffbFFEE32);
  Color sari = Color(0xffbFFD100);

  @override
  void initState() {
    isimcon.addListener(() => setState(() {}));
  }
  @override
  void dispose() {
    super.dispose();
    isimcon.dispose();
  }

  _profil(){
    if(profil['resim'] == null)
      return Container(
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: AssetImage('assets/images/kahve.jpg'), fit: BoxFit.cover),
              border: Border.all(color: siyah, width: 5)
          ),
          child: Icon(Icons.account_circle, color: Colors.grey,)
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

  @override
  Widget build(BuildContext context) {

    final size = MediaQuery.of(context).size;
    //var Itemcards = binalist.map((e) => null);
    List<Widget> Itemcards = [];
    for(int i = 0; i < 5; i++)
      Itemcards.add(ItemCard(ad: kopyabina[0][0], sehir: kopyabina[0][1], resim: kopyabina[0][2],
        begeni: kopyabina[0][3], ziyaret: kopyabina[0][4], hava: kopyabina[0][5], sicaklik: kopyabina[0][6],
        renk: kopyabina[0][7], renk2: kopyabina[0][8], tarih: kopyabina[0][9], yildiz: kopyabina[0][10],
        mesaj: kopyabina[0][11], mekanlar: kopyabina[0][12], w: size.width, h: size.height,),);

    int abc;
    bool thema = true;

    return Container(
      child: Stack(children: [
        Container(
          width: size.width,
          //color: siyah,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/ekran6.PNG'), fit: BoxFit.cover)),
        ),
        SingleChildScrollView(
          child: Container(
            color: Colors.transparent,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 200,),
                Stack(overflow: Overflow.visible,
                  children: [
                    Positioned(bottom: 0, right: -75,
                      child: Container(width: size.width * 0.25, height: 60,
                        decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(right: Radius.circular(30)), color: Colors.yellow),
                        child: Center(
                            widthFactor: 0.2,
                            child: GestureDetector(
                                onTap: (){setState(() {
                                  abc++;
                                });},
                                child: Text('Filtre', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),)
                            )
                        ),
                      ),
                    ),
                    SizedBox(
                      width: size.width *0.8,
                      child: TextFormField(
                        validator: (name){if(name.isEmpty){return 'please enter your user name';}},
                        controller: isimcon,
                        decoration: InputDecoration(
                          fillColor: Colors.white,
                          filled: true,
                          labelText: 'Şehir Adı',
                          prefixIcon: Icon(Icons.search),
                          enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
                          focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
                        ),
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.done,
                      ),
                    ),
                  ],),
                SizedBox(height: 80,),
                Text("Kullanıcılar arasında trend", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: gri),),
                SizedBox(height: 20,),
                SizedBox(height: 150,
                  child: GridView.builder(
                      itemCount: binalist.length,
                      scrollDirection: Axis.horizontal,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 1,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 20,
                        childAspectRatio: 0.60,
                      ),
                      itemBuilder: (context, index) => TrendCard(ad: kopyabina[0][0], sehir: kopyabina[0][1], resim: kopyabina[0][2],
                        begeni: kopyabina[0][3], ziyaret: kopyabina[0][4], hava: kopyabina[0][5], sicaklik: kopyabina[0][6],
                        renk: kopyabina[0][7], renk2: kopyabina[0][8], tarih: kopyabina[0][9], yildiz: kopyabina[0][10],
                        mesaj: kopyabina[0][11], mekanlar: kopyabina[0][12], w: size.width, h: size.height,)),
                ),
                SizedBox(height: 80,),
                Text("Bunlara'da bakabilirsiniz", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: gri),),
                SizedBox(height: 20,),
                SizedBox(child: Column(children: Itemcards,),),
                SizedBox(height: 80,)
              ],
            ),
          ),
        ),
      ],
      ),
    );
  }
}
class TrendCard extends StatelessWidget {
  @override
  String ad;
  String sehir;
  String resim;
  double begeni;
  double ziyaret;
  String hava;
  double sicaklik;
  Color renk;
  Color renk2;
  String tarih;
  double yildiz;
  List<List> mesaj;
  List<List> mekanlar;
  double w;
  double h;

  TrendCard({this.ad, this.sehir, this.resim, this.begeni, this.ziyaret, this.hava, this.sicaklik, this.renk, this.renk2, this.tarih, this.yildiz, this.mesaj, this.mekanlar, this.h, this.w});
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: renk, borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(bottom: 0, right: 0,
            child: GestureDetector(
              onTap: ()=> Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> ItemHero(
                    ad: ad, resim: resim, renk: renk, renk2: renk2, tarih: tarih, yildiz: yildiz, mesaj: mesaj, mekanlar: mekanlar,
                    hava: hava, sicaklik: sicaklik, press: () => Navigator.pop(context), h: h, w: w,))),
              child: Container(height: 150, width: 200,
                decoration: BoxDecoration(
                    color: Colors.blue, borderRadius: BorderRadius.all(Radius.circular(25)),
                    image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover)
                ),
              ),
            ),
          ),
          Positioned(top: 0, right: 5,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  SizedBox(height: 30, width: 30, child: Image.asset(hava, fit: BoxFit.cover,)),
                  SizedBox(height: 5,),
                  Text(sicaklik.toString(), style: TextStyle(fontSize: 20),)
                ],
              )
          ),
          Positioned(top: 0, left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(ad, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
                  Text(sehir, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ],
              )
          ),
          Positioned(bottom: 5, left: 5,
            child: Row(
              children: [
                Icon(Icons.local_fire_department, size: 30,),
                Text(begeni.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
              ],
            ),
          )
        ],
      ),
    );
  }
}
class ItemCard extends StatelessWidget {
  @override
  double w;
  String ad;
  String sehir;
  String resim;
  double begeni;
  double ziyaret;
  String hava;
  double sicaklik;
  Color renk;
  Color renk2;
  String tarih;
  double yildiz;
  List<List> mesaj;
  List<List> mekanlar;
  double h;

  ItemCard({this.ad, this.sehir, this.resim, this.begeni, this.ziyaret, this.hava, this.sicaklik, this.renk, this.renk2, this.tarih, this.yildiz, this.mesaj, this.mekanlar, this.w, this.h});
  Widget build(BuildContext context) {
    return Container(
        height: w * (0.6), width: w,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            GestureDetector(
              onTap: ()=> Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> ItemHero(
                    ad: ad, resim: resim, renk: renk, renk2: renk2, tarih: tarih, yildiz: yildiz, mesaj: mesaj, mekanlar: mekanlar,
                    hava: hava, sicaklik: sicaklik, press: () => Navigator.pop(context), h: h, w: w,))),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 35),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                    image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover)
                ),
              ),
            ),
            Positioned(
              bottom: 8, left: w * 0.15,
              child: Container(
                  height: w * 0.15, width: w * 0.7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30), top: Radius.circular(20)), color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.35,
                        child:  Row(
                          children: [
                            Icon(Icons.local_fire_department, size: 30, color: Colors.red,),
                            Text(begeni.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),),
                          ],
                        ),
                      ),
                      SizedBox(width: w * 0.35,
                        child:  Row(
                          children: [
                            Icon(Icons.supervisor_account_outlined, size: 30, color: Colors.green,),
                            Text(ziyaret.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.green),),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Positioned(top: 16, left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ad, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                    Text(sehir, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  ],
                )
            ),
            Positioned(bottom: 70, right: 25,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(sicaklik.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(width: 10,),
                    SizedBox(height: 40, width: 40, child: Image.asset(hava, fit: BoxFit.cover,)),
                  ],
                )
            ),
          ],
        )
    );
  }
}