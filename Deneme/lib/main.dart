import 'package:deneme/BlokSayfasi.dart';
import 'package:deneme/anasayfa.dart';
import 'package:flutter/material.dart';
import 'BlockSearch.dart';
import 'HttpVeriCekme.dart';
import 'Mesajsayfasi.dart';
import 'SearchCity.dart';
import 'SehirBilgi.dart';
import 'SingupLogin.dart';
import 'animasyonörnek.dart';
import 'planlamasayası.dart';
import 'plansayfa.dart';
import 'planözellikleri.dart';

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

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: myApp(),
    );
  }
}
class myApp extends StatefulWidget {
  @override
  _myAppState createState() => _myAppState();
}
class _myAppState extends State<myApp> {
  int page = 2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var pages = [
      plansayfa(),
      searchCity(),
      anaSayfa(),
      blokSayfa()
    ];

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        //appBar: AppBarMethod(),
        body: pages[page],
        bottomNavigationBar: BottomNavigationBarMethod(size, context),
      ),
    );
  }
  AppBar AppBarMethod() {
    return AppBar(
      backgroundColor: Color(0xff30475E),
      actions: [
        Icon(Icons.account_circle, size: 40, color: gr,),
        SizedBox(width: 10,)
      ],
      centerTitle: true,
      title: Container(
        margin: EdgeInsets.all(10),
        child: Image.asset('assets/logo.png'),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
      ),
    );
  }
  Container BottomNavigationBarMethod(Size size, BuildContext context) {
    return Container(
      width: size.width,
      color: Colors.transparent,
      height: 80,
      child: Stack(children: [
        CustomPaint(size: Size(size.width, 80), painter: altbuton(renk: Color(0xff30475E)),),
        Center(
          heightFactor: 0.6,
          child: FloatingActionButton(
            //onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SeyehatHaz()));},
            backgroundColor: Color(0xff30475E),
            child: Icon(Icons.add_circle_outline_outlined, size: 50, color: Color(0xffFCA311)),
            elevation: 0.1,
          ),
        ),
        Container(
          width: size.width,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.map, size: 40, color: Color(0xffFCA311)),
                  onPressed: (){setState(() {page = 0;});}
              ),
              IconButton(icon: Icon(Icons.home, size: 40, color: Color(0xffFCA311)),
                  onPressed: (){setState(() {page = 2;});}
              ),
              Container(width: size.width*0.2,),
              IconButton(icon: Icon(Icons.apartment_rounded, size: 40, color: Color(0xffFCA311),),
                  onPressed: (){setState(() {page = 1;});}
              ),
              IconButton(icon: Icon(Icons.account_balance_rounded, size: 40, color: Color(0xffFCA311)),
                  onPressed: (){setState(() {page = 3;});}
              ),
            ],),
        )
      ],),
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