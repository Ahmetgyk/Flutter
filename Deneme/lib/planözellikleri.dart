import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'server.dart';

Color siya = Color(0xff222831);
Color koyugri = Color(0xff333333);
Color gr = Color(0xffDDDDDD);
Color aciksiya = Color(0xff333533);
Color kirmiz = Color(0xff990100);
Color yesi = Color(0xffC6DE41);
Color lacivert = Color(0xff30475E);
Color sar = Color(0xffFCA311);

List<String> haftagun = ["PZT", "SAL", "CAR", "PER", "CUM", "CMT", "PAZ"];

class PlanDetay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: plandetay(Planlar[0]["isim"], Planlar[0]["baslangic"], Planlar[0]["bitis"], Planlar[0]["plan"]),
    );
  }
}
class plandetay extends StatefulWidget {
  String isim;
  String baslangic;
  String bitis;
  List<List<dynamic>> plan;
  plandetay(this.isim, this.baslangic, this.bitis, this.plan);

  @override
  _plandetayState createState() => _plandetayState(isim, baslangic, bitis, plan, plan[0][0].day);
}
class _plandetayState extends State<plandetay> {
  String isim;
  String baslangic;
  String bitis;
  List<List<dynamic>> plan;
  int bugun;
  _plandetayState(this.isim, this.baslangic, this.bitis, this.plan, this.bugun);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double bosluk = 20;
    double margin = 10;
    double radius = 25;

    int gun = plan[plan.length - 1][1].day - plan[0][0].day + 1;

    List<Widget> Gunler = [];
    for(int i = 0; i < gun; i++){
      int hafta = DateTime(plan[i][0].year, plan[i][0].month,
          plan[0][0].day + i).weekday;
      Gunler.add(DateCell(margin, radius, haftagun[hafta - 1], plan[0][0].day + i));
    }

    List<Widget> Hareketler = [];
    for(int i = 0; i < plan.length; i++)
      if(plan[i][0].day == bugun)
        Hareketler.add(hareketCell(size, margin, radius, bosluk, "13.30", "17.30", plan[i][2], plan[i][4]));

    return Scaffold(
      backgroundColor: lacivert,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            ClipPath(
              clipper: MyCustomClipper(radius),
              child: Container(
                color: siya,
                width: size.width,
                height: size.height * 0.35,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 30,),
                Container(
                  width: size.width - 2 * margin, height: size.height * 0.2,
                  margin: EdgeInsets.only(left: margin, right: margin, top: margin),
                  padding: EdgeInsets.all(margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: isim,
                        child: Text(isim, style: TextStyle(color: gr, fontSize: 45, fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: bosluk,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Çarşamba", style: TextStyle(color: gr, fontSize: 25, fontWeight: FontWeight.bold),),
                              Text(Planlar[0]["baslangic"], style: TextStyle(color: gr, fontSize: 15),),
                            ],
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("Cuma", style: TextStyle(color: gr, fontSize: 25, fontWeight: FontWeight.bold),),
                              Text(Planlar[0]["bitis"], style: TextStyle(color: gr, fontSize: 15),),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width, margin: EdgeInsets.only(left: margin, right: margin, bottom: margin),
                  child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(children: Gunler,)
                  ),
                ),
                Container(
                  width: size.width - 2 * margin,
                  margin: EdgeInsets.only(left: margin, right: margin, bottom: margin),
                  padding: EdgeInsets.all(margin),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(color: aciksiya, width: 3),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: -4,
                          blurRadius: 15,
                          offset: Offset(6, 6),
                          color: Colors.black)
                    ],
                    color: lacivert,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          SizedBox(width: 10,),
                          Text("Bugün:", style: TextStyle(color: gr, fontSize: 15),),
                          SizedBox(width: 5,),
                          Icon(Icons.wb_sunny, size: 20,),
                          SizedBox(width: 5,),
                          Text("25.5", style: TextStyle(fontSize: 20, color: gr)),
                          Spacer(),
                          Text("Gözlük almayı unutma", style: TextStyle(color: gr, fontSize: 17),),
                          SizedBox(width: 10,),
                        ],
                      ),
                      Divider(color: aciksiya, height: 25, thickness: 4, indent: 0, endIndent: 25,),
                      Column(
                        children: Hareketler,
                      ),
                    ],
                  ),
                ),
                Container(
                  width: size.width - 2 * margin, height: size.height * 0.3,
                  margin: EdgeInsets.only(left: margin, right: margin, bottom: margin),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(color: aciksiya, width: 3),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: -4,
                            blurRadius: 15,
                            offset: Offset(6, 6),
                            color: Colors.black)
                      ],
                      color: lacivert,
                      image: DecorationImage(image: AssetImage("server/harita.jpg"), fit: BoxFit.cover)
                  ),
                ),
                Container(
                  width: size.width - 2 * margin, height: size.height * 0.3,
                  margin: EdgeInsets.only(left: margin, right: margin, bottom: margin),
                  padding: EdgeInsets.all(margin),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(color: aciksiya, width: 3),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: -4,
                          blurRadius: 15,
                          offset: Offset(6, 6),
                          color: Colors.black
                      )
                    ],
                      color: lacivert,
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: size.width * 0.4, height: size.height * 0.3,
                        margin: EdgeInsets.all(margin / 2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: siya),
                        child: Center(child: Icon(Icons.fastfood, size: 90, color: gr,),),
                      ),
                      SizedBox(
                        width: size.width * 0.45,
                        child: Text("Gözlük almayı unutma", style: TextStyle(color: gr, fontSize: 22),),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      )
    );
  }

  GestureDetector DateCell(double margin, double radius, String hafta, int gun) {
    if(gun == bugun)
      return GestureDetector(
        child: Container(
          width: 60, height: 80,
          margin: EdgeInsets.all(margin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            boxShadow: [
              BoxShadow(
                  spreadRadius: -4,
                  blurRadius: 15,
                  offset: Offset(6, 0),
                  color: Colors.black)
            ],
            color: gr
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(hafta, style: TextStyle(color: lacivert, fontSize: 20, fontWeight: FontWeight.bold),),
              Text(gun.toString(), style: TextStyle(color: lacivert, fontSize: 17, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        onTap: (){setState(() {bugun = gun;});},
      );
    else
      return GestureDetector(
        child: Container(
          width: 60, height: 80,
          margin: EdgeInsets.all(margin / 2),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: aciksiya, width: 3),
            boxShadow: [
              BoxShadow(
                  spreadRadius: -4,
                  blurRadius: 15,
                  offset: Offset(6, 0),
                  color: Colors.black)
            ],
            color: lacivert
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(hafta, style: TextStyle(color: gr, fontSize: 20, fontWeight: FontWeight.bold),),
              Text(gun.toString(), style: TextStyle(color: gr, fontSize: 17, fontWeight: FontWeight.bold),),
            ],
          ),
        ),
        onTap: (){setState(() {bugun = gun;});},
      );
  }

  Container hareketCell(Size size, double margin, double radius, double bosluk, String baslangic, String bitis,
      String mekan, String aciklama,) {
    return Container(
        width: size.width * 0.95, height: 90,
        margin: EdgeInsets.symmetric(horizontal: margin,),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Spacer(),
                Text(baslangic, style: TextStyle(fontSize: 15, color: gr),),
                Spacer(flex: 2,),
                Text(bitis, style: TextStyle(fontSize: 15, color: gr),),
                Spacer(),
              ],
            ),
            Spacer(flex: 2,),
            Stack(
                children: [
                  RotatedBox(
                    quarterTurns: 1,
                    child: Divider(color: aciksiya, height: 45, thickness: 4, indent: 0, endIndent: 0,),
                  ),
                  Positioned(
                    top: 25, left: 4,
                    child: CircleAvatar(
                        radius: 18,
                        backgroundColor: aciksiya,
                        child: Icon(Icons.account_balance_sharp, size: 20, color: lacivert,)
                    ),
                  )
                ]
            ),
            Spacer(flex: 1,),
            Container(
              height: size.height * 0.13, width: size.width * 0.3,
              margin: EdgeInsets.symmetric(vertical: margin / 2,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                image: DecorationImage(image: AssetImage("server/ayasofya.jpg"), fit: BoxFit.fitHeight),
              ),
            ),
            SizedBox(width: 10,),
            SizedBox(
              width: size.width * 0.3 - 10,
              child: Text(aciklama, style: TextStyle(color: gr, fontSize: 17),),
            ),
            Spacer(flex: 1,),
          ],
        )
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
    path.quadraticBezierTo(radius / 4, size.height - (radius * 3/4), radius, size.height - radius);
    path.lineTo(size.width - radius, size.height - radius);
    path.quadraticBezierTo(size.width - (radius / 4), size.height - (radius * 3/4), size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipper oldClipper) => false;

}