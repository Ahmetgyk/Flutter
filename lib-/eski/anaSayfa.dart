import 'package:flutter/material.dart';
import 'package:flutter_app/sehirsayfa.dart';
import 'package:flutter_app/server.dart';
import 'package:flutter_app/ayarlarSayfasi.dart';
import 'package:flutter_app/profilSayfasi.dart';
import 'purnurunsayfas.dart';
import 'purnursehirsayfa.dart';
import 'takvimkopyası.dart';

class AnaSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ana(),
    );
  }
}
class ana extends StatefulWidget{
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}
class _AnaSayfaState extends State<ana> {
  Color siyah = Color(0xffb202020);
  Color aciksiyah = Color(0xffb333533);
  Color gri = Color(0xffbD6D6D6);
  Color aciksari = Color(0xffbFFEE32);

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

  bool thema = true;

  int _page = 2;
  final pages = [
    pSehirSayfa(),
    pSehirSayfa(),
    Panasayfa(),
    HomePage()
  ];

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        backgroundColor: aciksiyah,
        actions: [
          _profil(),
          SizedBox(width: 10,)
        ],
        centerTitle: true,
        title: RichText(
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: 'Tour', style: TextStyle(color: Colors.lightBlue, fontSize: 50,)),
                TextSpan(text: 'Key', style: TextStyle(color: Color(0xffa5e65a), fontSize: 55)),
              ]
          ),
        ),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
        ),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: aciksiyah),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipOval(
                    child: Container(
                      color: gri,
                      width: 100.0,
                      height: 100.0,
                      child: Image.file(profil['resim'], fit: BoxFit.cover),
                    ),
                  ),
                  Text(profil['ad'], style: TextStyle(fontSize: 20),)
                ],
              ),
            ),
            draweTile(ad: 'Profil', icon: Icons.account_circle,
              ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));
              },
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
              child: Container(
                decoration: BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.blueAccent))
                ),
                child: InkWell(
                  splashColor: Colors.blueAccent,
                  onTap: (){setState(() {thema = !thema;});},
                  child: Container(
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.settings_applications),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text('Darkmode' ,style: TextStyle(fontSize: 16.0),),)
                          ],
                        ),
                        Switch(value: thema, onChanged: (val){setState(() {thema = val;});}),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            draweTile(ad: 'İletişim', icon: Icons.call,
              ontap: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));
              },
            ),
            draweTile(ad: 'Çıkış', icon: Icons.highlight_off, ontap: (){},),
          ],
        ),
      ),
      body: pages[_page],
      bottomNavigationBar: Container(
        width: size.width,
        color: Colors.transparent,
        height: 80,
        child: Stack(children: [
          CustomPaint(size: Size(size.width, 80), painter: altbuton(renk: aciksiyah),),
          Center(
            heightFactor: 0.6,
            child: FloatingActionButton(
              onPressed: (){},
              backgroundColor: aciksiyah,
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
                IconButton(icon: Icon(Icons.map, size: 40, color: aciksari,),
                    onPressed: (){setState(() {_page = 0;});}
                ),
                IconButton(icon: Icon(Icons.apartment_rounded, size: 40, color: aciksari,),
                    onPressed: (){setState(() {_page = 1;});}
                ),
                Container(width: size.width*0.2,),
                IconButton(icon: Icon(Icons.home, size: 40, color: aciksari,),
                    onPressed: (){setState(() {_page = 2;});}
                ),
                IconButton(icon: Icon(Icons.account_balance_rounded, size: 40, color: aciksari,),
                    onPressed: (){setState(() {_page = 3;});}
                ),
              ],),
          )
        ],),
      ),
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
  Color renk;

  altbuton({this.renk});
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = renk..style = PaintingStyle.fill;
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



