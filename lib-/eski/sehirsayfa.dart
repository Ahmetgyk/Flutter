import 'package:flutter/material.dart';
import 'package:flutter_app/server.dart';
import 'package:flutter_app/takvimden.dart';
import 'sehirhero.dart';
import 'dart:math';
import 'package:flutter_app/server.dart';

class SehirSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var containers = binalar.map((bina) => Container(margin: EdgeInsets.all(8), padding: EdgeInsets.all(8), color: Colors.green,)).toList();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: sehirsayfa()
    );
  }
}
class sehirsayfa extends StatefulWidget {
  @override
  _sehirsayfaState createState() => _sehirsayfaState();
}
class _sehirsayfaState extends State<sehirsayfa> {
  final isimcon = TextEditingController();
  int randomNumber;

  @override
  void initState() {
    isimcon.addListener(() => setState(() {}));
    Random random = new Random();
    randomNumber = random.nextInt(arkafon.length);
  }
  @override
  void dispose() {
    super.dispose();
    isimcon.dispose();
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

    return Scaffold(
      appBar: AppBar(
        actions: [Icon(Icons.account_circle, size: 35,), SizedBox(width: 10,)],
        elevation: 0,
        title: RichText(
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Tour', style: TextStyle(color: Colors.blue, fontSize: 50,)),
                TextSpan(text: 'Key', style: TextStyle(color: Color(0xffa5e65a), fontSize: 55)),
              ]
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: Colors.red,),),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.lightBlue),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      color: Colors.blue,
                      width: 100.0,
                      height: 100.0,
                      child: Image.asset('assets/images/kahve.jpg'),
                    ),
                  ),
                  Text('kullanıcı adı', style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
            draweTile(ad: 'Profil', icon: Icons.account_circle, ontap: (){},),
            draweTile(ad: 'Ayarlar', icon: Icons.settings, ontap: (){},),
            draweTile(ad: 'Çikiş', icon: Icons.highlight_off, ontap: (){},),
          ],
        ),
      ),
      body: Container(
        child: Stack(children: [
          Container(
            width: size.width,
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage(arkafon[randomNumber]), fit: BoxFit.cover)),
          ),
          SingleChildScrollView(
            child: Container(
              color: Colors.transparent,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text('Hangi şehri', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                  SizedBox(height: 10,),
                  Text('keşfetmek istiyorsun?', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
                  SizedBox(height: 10,),
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
                  SizedBox(height: 10,),
                  Text("Kullanıcılar arasında trend", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),),
                  SizedBox(height: 10,),
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
                  SizedBox(height: 10,),
                  Text("Bunlara'da bakabilirsiniz", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic),),
                  SizedBox(height: 10,),
                  SizedBox(child: Column(children: Itemcards,),),
                  SizedBox(height: 150,)
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              left: 0,
              child: Container(
                width: size.width,
                height: 80,
                child: Stack(children: [
                  CustomPaint(size: Size(size.width, 80), painter: altbuton(),),
                  Center(
                    heightFactor: 0.6,
                    child: FloatingActionButton(
                      onPressed: (){},
                      backgroundColor: Colors.blue,
                      child: Icon(Icons.add_circle_outline_outlined, size: 50,),
                      elevation: 0.1,
                    ),
                  ),
                  Container(
                    width: size.width,
                    height: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        IconButton(icon: Icon(Icons.map, size: 40,), onPressed: (){}),
                        IconButton(icon: Icon(Icons.apartment_rounded, size: 40,), onPressed: (){}),
                        Container(width: size.width*0.2,),
                        IconButton(icon: Icon(Icons.home, size: 40,), onPressed: (){}),
                        IconButton(icon: Icon(Icons.account_balance_rounded, size: 40,), onPressed: (){}),
                      ],),
                  )
                ],),
              )
          ),
        ],
        ),
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
                  image: DecorationImage(image: AssetImage(resim), fit: BoxFit.fitHeight)
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
class draweTile extends StatelessWidget{
  String ad;
  IconData icon;
  Function ontap;

  draweTile({this.ad, this.icon, this.ontap});
  Widget build(BuildContext context){
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.blueAccent))
        ),
        child: InkWell(
          splashColor: Colors.blueAccent,
          onTap: ontap,
          child: Container(
            height: 40,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(icon),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(ad ,style: TextStyle(fontSize: 16.0),),
                    )
                  ],
                ),
                Icon(Icons.arrow_right)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
class altbuton extends CustomPainter{
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = Color(0xffa5e65a)..style = PaintingStyle.fill;
    Path path = Path()..moveTo(0, 20);
    path.quadraticBezierTo(size.width*0.2, 0, size.width*0.35, 0);
    path.quadraticBezierTo(size.width*0.4, 0, size.width*0.4, 20);
    path.arcToPoint(Offset(size.width*0.6, 20),
        radius: Radius.circular(10), clockwise: false);
    path.quadraticBezierTo(size.width*0.6, 0, size.width*0.65, 0);
    path.quadraticBezierTo(size.width*0.8, 0, size.width, 20);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();
    canvas.drawShadow(path, Colors.black, 5, true);
    canvas.drawPath(path, paint);
  }
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}