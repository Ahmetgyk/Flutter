import 'package:flutter/material.dart';
import 'package:gtourkey/anaSayfa.dart';


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

Color koyuyesil = Color(0xff3E432E);
Color acikyesil = Color(0xff616F39);

Color buton = Color(0xffF3A953);
Color arkafon = Color(0xffD6D6D6);
Color altbutonlar = Color(0xff476072);

void main() => runApp(Iskelet());

class Iskelet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: iskelet(),
    );
  }
}
class iskelet extends StatefulWidget {
  @override
  _IskeletState createState() => _IskeletState();
}
class _IskeletState extends State<iskelet> {
  int page = 2;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    var pages = [
      Container(color: siya,)
    ];

    return SafeArea(
      child: Scaffold(
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBarMethod(),
        body: anaSayfa(),
        bottomNavigationBar: BottomNavigationBarMethod(size, context),
      ),
    );
  }
  AppBar AppBarMethod() {
    return AppBar(
      backgroundColor: altbutonlar,
      actions: [
        Container(
          width: 50,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: buton,
            borderRadius: BorderRadius.circular(10)
          ),
        ),
        SizedBox(width: 10,)
      ],
      centerTitle: true,
      title: Container(
        margin: EdgeInsets.all(10),
        child: Text('TourKey', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(20))
      ),
    );
  }
  Container BottomNavigationBarMethod(Size size, BuildContext context) {
    return Container(
      width: size.width,
      color: Colors.transparent,
      child: Stack(
        overflow: Overflow.visible,
        children: [
          CustomPaint(size: Size(size.width, 80), painter: altbuton(altbutonlar)),
          Positioned(
            left: size.width / 2 - 37.5, bottom: 22,
            child: Container(
              width: 75, height: 75,
              decoration: BoxDecoration(
                color: altbutonlar,
                borderRadius: BorderRadius.circular(40),
              ),
              child: Icon(Icons.home_rounded, size: 70, color: buton,),
            )
          ),
          Container(
            width: size.width,
            height: 80,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(icon: Icon(Icons.map, size: 40, color: buton),
                    onPressed: (){setState(() {page = 0;});}
                ),
                IconButton(icon: Icon(Icons.home_max_rounded, size: 40, color: buton),
                    onPressed: (){setState(() {page = 2;});}
                ),
                Container(width: size.width*0.2,),
                IconButton(icon: Icon(Icons.apartment_rounded, size: 40, color: buton,),
                    onPressed: (){setState(() {page = 1;});}
                ),
                IconButton(icon: Icon(Icons.account_balance_rounded, size: 40, color: buton),
                    onPressed: (){setState(() {page = 3;});}
                ),
              ],),
          )
        ],
      ),
    );
  }
}
class altbuton extends CustomPainter{
  Color renk;

  altbuton(this.renk);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = renk..style = PaintingStyle.fill;
    Path path = Path();
    path.lineTo(size.width*0.35, 0);
    path.quadraticBezierTo(size.width*0.4, 0, size.width*0.4, 20);
    path.arcToPoint(Offset(size.width*0.6, 20), radius: Radius.circular(10), clockwise: false);
    path.quadraticBezierTo(size.width*0.6, 0, size.width*0.65, 0);
    path.lineTo(size.width, 0);
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