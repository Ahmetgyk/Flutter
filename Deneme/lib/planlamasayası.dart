import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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

class PlanlamaSayfasi extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: planlamaSayfasi(),
    );
  }
}
class planlamaSayfasi extends StatefulWidget {
  @override
  _planlamaSayfasiState createState() => _planlamaSayfasiState();
}
class _planlamaSayfasiState extends State<planlamaSayfasi> {
  double bosluk = 20;
  double margin = 10;
  double radius = 25;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> biletayrimi = [];
    double birim = (size.width - 2 * (radius)) / 20;
    for(int i = 0; i < 19; i++) biletayrimi.add(
      SizedBox(width: birim, child: Center(child: Icon(Icons.brightness_1, size: size.width * 0.04, color: siya,))),);

    return Scaffold(
      backgroundColor: siya,
      body: Column(
        children: [
          Stack(
            overflow: Overflow.visible,
            children: [
              Container(
                width: size.width, height: size.height * 0.3,
                margin: EdgeInsets.only(top: margin, left: margin, right: margin),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: lacivert
                ),
                child:  Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("plan İsmi", style: TextStyle(color: gr, fontSize: 45, fontWeight: FontWeight.bold),),
                    SizedBox(height: bosluk,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text("Çarşamba", style: TextStyle(color: gr, fontSize: 25, fontWeight: FontWeight.bold),),
                            Text("3 nisan 2022", style: TextStyle(color: gr, fontSize: 15),),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text("Cuma", style: TextStyle(color: gr, fontSize: 25, fontWeight: FontWeight.bold),),
                            Text("7 nisan 2022", style: TextStyle(color: gr, fontSize: 15),),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Positioned(
                bottom: -size.width * 0.02, left: radius + birim / 2,
                child: Row(children: biletayrimi,)
              ),
            ],
          ),
          Container(
            width: size.width, height: size.height * 0.66,
            margin: EdgeInsets.only(bottom: margin, left: margin, right: margin),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                boxShadow: [
                  BoxShadow(
                      spreadRadius: -4,
                      blurRadius: 25,
                      offset: Offset(7, 17),
                      color: Colors.black
                  )
                ],
                color: lacivert
            ),
            child:  Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("plan İsmi", style: TextStyle(color: gr, fontSize: 45, fontWeight: FontWeight.bold),),
                SizedBox(height: bosluk,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Çarşamba", style: TextStyle(color: gr, fontSize: 25, fontWeight: FontWeight.bold),),
                        Text("3 nisan 2022", style: TextStyle(color: gr, fontSize: 15),),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text("Cuma", style: TextStyle(color: gr, fontSize: 25, fontWeight: FontWeight.bold),),
                        Text("7 nisan 2022", style: TextStyle(color: gr, fontSize: 15),),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
class MyCustomClipper extends CustomClipper<Path> {
  double radius;

  MyCustomClipper(this.radius);

  @override
  Path getClip(Size size,) {
    final path = Path();
    path.lineTo(0, size.height);
    path.quadraticBezierTo(radius / 4, size.height - (radius * 3 / 4), radius,
        size.height - radius);
    path.lineTo(size.width - radius, size.height - radius);
    path.quadraticBezierTo(
        size.width - (radius / 4), size.height - (radius * 3 / 4), size.width,
        size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipper oldClipper) => false;
}