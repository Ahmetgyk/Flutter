import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'Mesajsayfasi.dart';
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

class Sehirbilgi extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: sehirbilgi(30, 10, 20, Sehirler[1]["isim"], Sehirler[1]["tür"], Sehirler[1]["resim"],
          Sehirler[1]["hava"], Sehirler[1]["ziyaret"], Sehirler[1]["kalp"], Sehirler[1]["tarih"], Sehirler[1]["benzerler"],
          Sehirler[1]["mekanlar"], Sehirler[1]["mesajlar"]),
      debugShowCheckedModeBanner: false,
    );
  }
}
class sehirbilgi extends StatefulWidget {

  double radius;
  double margin;
  double bosluk;
  String ad;
  String sehirtur;
  String resim;
  List<dynamic> havadurumu;
  int ziyaret;
  int kalp;
  String tarih;
  List<String> benzerler;
  List<String> mekanlar;
  List<dynamic> mesajlar;

  sehirbilgi(this.radius, this.margin, this.bosluk, this.ad, this.sehirtur,
      this.resim, this.havadurumu, this.ziyaret, this.kalp, this.tarih, this.benzerler, this.mekanlar, this.mesajlar);

  @override
  _sehirbilgiState createState() => _sehirbilgiState(radius, margin, bosluk, ad, sehirtur,
      resim, havadurumu, ziyaret, kalp, tarih, benzerler, mekanlar, mesajlar);
}

bool info = true;
bool audiOn = false;
double puan = 0;

class _sehirbilgiState extends State<sehirbilgi> {

  double radius;
  double margin;
  double bosluk;
  String ad;
  String sehirtur;
  String resim;
  List<dynamic> havadurumu;
  int ziyaret;
  int kalp;
  String tarih;
  List<String> benzerlr;
  List<String> mekanlr;
  List<dynamic> mesajlr;

  _sehirbilgiState(this.radius, this.margin, this.bosluk, this.ad, this.sehirtur,
      this.resim, this.havadurumu, this.ziyaret, this.kalp, this.tarih, this.benzerlr, this.mekanlr, this.mesajlr);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> benzerler = [];
    for(int i = 0; i < 2; i++)
      for(int i = 0; i < benzerlr.length; i++)
        for(int e = 0; e < Sehirler.length; e++)
          if(Sehirler[e]["isim"] == benzerlr[i])
            benzerler.add(RCard(size, radius, Sehirler[e]["resim"], Sehirler[e]["isim"],
                Sehirler[e]["tür"], Sehirler[e]["kalp"], Sehirler[e]["ziyaret"]));

    List<Widget> mekanlar = [];
    for(int i = 0; i < 2; i++)
      for(int i = 0; i < mekanlr.length; i++)
        for(int e = 0; e < Binalar.length; e++)
          if(Binalar[e]["isim"] == mekanlr[i])
            mekanlar.add(RCard(size, radius, Binalar[e]["resim"], Binalar[e]["isim"],
                Binalar[e]["mekan"], Binalar[e]["kalp"], Binalar[e]["ziyaret"]));


    int lastpuan = 0;
    List<dynamic> puanmesaj = [];
    for(int i = 0; i < mesajlr.length; i++){
      if(mesajlr[i][1] > mesajlr[lastpuan][1]){
        lastpuan = i;
        puanmesaj.clear();
        puanmesaj.add(mesajlr[i]);
      }
      if(mesajlr[i][1] == mesajlr[lastpuan][1]){
        lastpuan = i;
        puanmesaj.add(mesajlr[i]);
      }
    }
    int lastyear = 0;
    int lastmoon = 0;
    int lastday = 0;
    List<dynamic> maxyear = [];
    List<dynamic> maxmoon = [];
    List<dynamic> favMesaj = [];
    for(int i = 0; i < puanmesaj.length; i++){
      if(puanmesaj[i][2].year > puanmesaj[lastyear][2].year){
        lastyear = i;
        maxyear.clear();
        maxyear.add(puanmesaj[i]);
      }
      if(puanmesaj[i][2].year == puanmesaj[lastpuan][2].year){
        lastyear = i;
        maxyear.add(puanmesaj[i]);
      }
    }
    for(int i = 0; i < maxyear.length; i++){
      if(maxyear[i][2].month > maxyear[lastmoon][2].month){
        lastmoon = i;
        maxmoon.clear();
        maxmoon.add(maxyear[i]);
      }
      if(maxyear[i][2].month == maxyear[lastpuan][2].month){
        lastmoon = i;
        maxmoon.add(maxyear[i]);
      }
    }
    for(int i = 0; i < maxmoon.length; i++)
      if(maxmoon[i][2].month >= maxmoon[lastday][2].month)lastday = i;
    favMesaj = maxmoon[lastday];

    List<Widget> hava = [];
    for(int i = 0; i < havadurumu.length; i++) hava.add(havaCell(size, radius, havadurumu[i][0], havadurumu[i][1], havadurumu[i][2]));

    List<String> resimler = [
      "server/ayasofya.jpg",
      "server/istanbul.jpg",
      "server/izmir.jpg",
      "server/izmirsaatkulesi.jpeg",
      "server/kahramanmaraş.jpg",
      "server/kızkulesi.jpg",
      "server/ayasofya.jpg",
      "server/istanbul.jpg",
      "server/izmir.jpg",
      "server/izmirsaatkulesi.jpeg",
      "server/kahramanmaraş.jpg",
      "server/kızkulesi.jpg",
      "server/ayasofya.jpg",
      "server/istanbul.jpg",
      "server/izmir.jpg",
      "server/izmirsaatkulesi.jpeg",
      "server/kahramanmaraş.jpg",
      "server/kızkulesi.jpg",
    ];

    //SafeArea kullan

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: size.width,
          color: siya,
          child: Column(
            children: [
              SizedBox(height: size.height * 0.05,),
              buildHero(size, radius),
              info ? Bilgi(size, margin, radius, bosluk, benzerler, mekanlar, hava, favMesaj) : Resim(size, margin, radius, bosluk, resimler)
            ],
          ),
        ),
      ),
    );
  }

  Hero buildHero(Size size, double radius) {
    return Hero(
      tag: ad,
      child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              height: size.height * 0.28, width: size.width * 0.95,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover),
                borderRadius: BorderRadius.vertical(top: Radius.circular(radius)),
                border: Border.all(color: lacivert, width: 6),
              ),
            ),
            Positioned(
              bottom: 0, right: 0,
              child: RotatedBox(
                quarterTurns: 2,
                child: ClipPath(
                  clipper: MyCustomClipper(radius),
                  child: Container(
                    color: lacivert,
                    width: size.width * 0.95,
                    height: size.height * 0.105,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 7, right: size.width * 0.1,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    info = true;
                  });
                },
                child: Container(
                  height: size.height * 0.04, width: size.width * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius / 2),
                      color: gr
                  ),
                  child: Center(
                    child: Text("info", style: TextStyle(fontSize: 25),),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 7, left: size.width * 0.1,
              child: GestureDetector(
                onTap: (){
                  setState(() {
                    info = false;
                  });
                },
                child: Container(
                  height: size.height * 0.04, width: size.width * 0.25,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius / 2),
                      color: gr
                  ),
                  child: Center(
                    child: Text("photo", style: TextStyle(fontSize: 25),),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: size.height * 0.015, right: size.width * 0.395,
              child: GestureDetector(
                onTap: (){setState(() {audiOn = !audiOn;});},
                child: CircleAvatar(
                  backgroundColor: sar,
                  radius: 33,
                  child: Center(
                      child: Icon(Icons.directions_run, size: 40, color: gir,)
                  ),
                ),
              ),
            ),
            Positioned(
              top: 30, right: 30,
              child: CircleAvatar(
                backgroundColor: gr,
                radius: 23,
                child: Center(
                  child: Icon(Icons.star_border, size: 45, color: sar,),
                ),
              ),
            ),
          ]
      ),
    );
  }
  Column Bilgi(Size size, double margin, double radius, double bosluk, List<Widget> benzerler, List<Widget> mekanlar, List<Widget> hava, List<dynamic> favMesaj) {
    return Column(
      children: [
        Container(
          width: size.width * 0.95,
          margin: EdgeInsets.only(left: margin, right: margin,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
            color: lacivert,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(color: aciksiya, height: 15, thickness: 3, indent: 10, endIndent: 40,),
              isim(bosluk, size),
              Row(
                children: [
                  SizedBox(width: 25,),
                  tur(bosluk, size),
                ],
              ),
            ],
          ),
        ),
        audiOn ? Audio(bosluk, size, margin, radius) : SizedBox(height: 0,),
        SizedBox(height: bosluk / 2,),
        begeniziyaret(size, margin, radius),
        SizedBox(height: bosluk / 2,),
        HavaCizelgesi(size, margin, radius, hava),
        SizedBox(height: bosluk / 2,),
        hakkinda(bosluk, size, margin, radius),
        SizedBox(height: bosluk / 2,),
        FavoriMesaj(size, margin, radius, bosluk, favMesaj),
        SizedBox(height: bosluk / 2,),
        Mekanlar(size, margin, radius, bosluk, benzerler, mekanlar),
        SizedBox(height: bosluk / 2,),
        Benzer(size, margin, radius, bosluk, benzerler),
        SizedBox(height: bosluk / 2,),
      ],
    );
  }
  Column Resim(Size size, double margin, double radius, double bosluk, List<String> resimler) {
    return Column(
      children: [
        SizedBox(height: 55,),
        Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              height: size.height * 0.66 - 55, width: size.width * 0.95,
              child: StaggeredGridView.countBuilder(
                staggeredTileBuilder: (index) => index % 7 == 0
                    ? StaggeredTile.count(2, 2)
                    : StaggeredTile.count(1, 1),
                crossAxisCount: 3,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                itemCount: resimler.length,
                itemBuilder: (context, index) => Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(radius),
                    border: Border.all(color: lacivert, width: 6),
                    color: lacivert,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(radius),
                    child: Image.asset(resimler[index], fit: BoxFit.cover),
                  ),
                ),
              ),
            ),
            Positioned(
              top: -55, left: -size.width *0.025,
              child: Container(
                width: size.width * 0.95,
                margin: EdgeInsets.only(left: margin, right: margin,),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
                  color: lacivert,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Divider(color: aciksiya, height: 15, thickness: 3, indent: 10, endIndent: 40,),
                    isim(bosluk, size),
                  ],
                ),
              ),
            )
          ],
        ),
        SizedBox(height: bosluk / 2,),
      ],
    );
  }
  Column Audio(double bosluk, Size size, double margin, double radius) {
    return Column(
      children: [
        SizedBox(height: bosluk / 2,),
        Container(
          width: size.width * 0.95,
          margin: EdgeInsets.only(left: margin, right: margin,),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            color: lacivert,
          ),
          child: Column(
            children: [
              SizedBox(height: bosluk / 4,),
              Row(
                children: [
                  Spacer(),
                  Icon(Icons.skip_previous, size: 35, color: gr,),
                  Spacer(),
                  Icon(Icons.play_arrow_sharp, size: 45, color: gr,),
                  Spacer(),
                  Icon(Icons.skip_next_rounded, size: 35, color: gr,),
                  Spacer(),
                ],
              ),
              Row(
                children: [
                  Spacer(),
                  Text("${puan.toString()}"),
                  Slider(
                    min: 0, max: 25,
                    divisions: 25,
                    activeColor: siya,
                    value: puan,
                    onChanged: (value){setState(() {puan = value;});},
                  ),
                  Text("2.50"),
                  Spacer(),
                ],
              )
            ],
          )
        ),
      ],
    );
  }
  Stack FavoriMesaj(Size size, double margin, double radius, double bosluk, List favMesaj) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Container(
            width: size.width * 0.95,
            margin: EdgeInsets.only(left: margin, right: margin,),
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
                    Spacer(flex: 4,),
                    Text("${favMesaj[2].year}-${favMesaj[2].month}-${favMesaj[2].day}", style: TextStyle(fontSize: 20, color: siya),),
                    Spacer(flex: 2,),
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
        ),
        Positioned(
            top: -10, right: 0,
            child: GestureDetector(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context)=> mesajSay(mesajlr))),
              child: CircleAvatar(
                backgroundColor: aciksiya,
                radius: 30,
                child: Center(child: Icon(Icons.message, color: gr, size: 25,)),
              ),
            )
        ),
      ],
    );
  }
  Container HavaCizelgesi(Size size, double margin, double radius, List<Widget> hava) {
    return Container(
        width: size.width * 0.95, height: size.height * 0.17,
        margin: EdgeInsets.only(left: margin, right: margin,),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          color: lacivert,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: hava
        )
      );
  }
  Container havaCell(Size size, double radius, String gun, double sic, String durum) {
    return Container(
      height: size.height * 0.15, width: size.width * 0.11,
      margin: EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(gun, style: TextStyle(fontSize: 20, color: sar)),
          SizedBox(height: bosluk / 2,),
          Icon(Icons.device_thermostat, size: 20,),
          Divider(color: aciksiya, height: 20, thickness: 3, indent: 3, endIndent: 3,),
          Text(sic.toString(), style: TextStyle(fontSize: 20, color: gir)),
        ],
      ),
    );
  }
  Container Benzer(Size size, double margin, double radius, double bosluk, List<Widget> benzerler) {
    return Container(
      width: size.width * 0.95,
      margin: EdgeInsets.only(left: margin, right: margin,),
      padding: EdgeInsets.only(left: margin, right: margin,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: lacivert,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: bosluk,),
              SizedBox(
                width: size.width * 0.8,
                child:Text("Benzerler", style: TextStyle(fontSize: 30, color: yesi),),
              )
            ],
          ),
          SizedBox(height: bosluk / 6,),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: benzerler,
              )
          ),
          SizedBox(height: bosluk,),
        ],
      ),
    );
  }
  Container Mekanlar(Size size, double margin, double radius, double bosluk, List<Widget> benzerler, List<Widget> mekanlar) {
    return Container(
      width: size.width * 0.95,
      margin: EdgeInsets.only(left: margin, right: margin,),
      padding: EdgeInsets.only(left: margin, right: margin,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: lacivert,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: bosluk,),
              SizedBox(
                width: size.width * 0.8,
                child:Text("Şehirdeki Mekanlar", style: TextStyle(fontSize: 30, color: yesi),),
              )
            ],
          ),
          SizedBox(height: bosluk / 6,),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: EdgeInsets.symmetric(horizontal: margin),
              child: Row(
                children: mekanlar,
              )
          ),
          SizedBox(height: bosluk,),
        ],
      ),
    );
  }
  Container hakkinda(double bosluk, Size size, double margin, double radius) {
    return Container(
      width: size.width * 0.95,
      margin: EdgeInsets.only(left: margin, right: margin,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        color: lacivert,
      ),
      child: Row(
            children: [
              SizedBox(width: bosluk,),
              Column(
                children: [
                  SizedBox(height: bosluk / 2,),
                  SizedBox(
                      width: size.width * 0.8,
                      child: Text("Hakkında", style: TextStyle(fontSize: 30, color: sar, fontWeight: FontWeight.bold),)
                  ),
                  SizedBox(height: bosluk / 2,),
                  SizedBox(
                      width: size.width * 0.8,
                      child: Text(tarih, style: TextStyle(fontSize: 20, color: gir),)
                  ),
                  SizedBox(height: bosluk / 2,),
                ],
              )
            ],
          ),
    );
  }
  Row begeniziyaret(size, double margin, double radius) {
    return Row(
          children: [
            Spacer(),
            Container(
              width: size.width * 0.42,
              margin: EdgeInsets.only(left: margin, right: margin,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: lacivert,
              ),
              child: Column(
                children: [
                  Text("Beğeni", style: TextStyle(fontSize: 15, color: gir, fontWeight: FontWeight.w500),),
                  Text(kalp.toString(), style: TextStyle(fontSize: 25, color: yesi, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Spacer(flex: 3,),
            Container(
              width: size.width * 0.42,
              margin: EdgeInsets.only(left: margin, right: margin,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: lacivert,
              ),
              child: Column(
                children: [
                  Text("Ziyaret", style: TextStyle(fontSize: 15, color: gir, fontWeight: FontWeight.w500),),
                  Text(ziyaret.toString(), style: TextStyle(fontSize: 25, color: kirmiz, fontWeight: FontWeight.w500),),
                ],
              ),
            ),
            Spacer(),
          ],
        );
  }
  Row tur(double bosluk, Size size) {
    return Row(
          children: [
            SizedBox(width: bosluk,),
            SizedBox(
                width: size.width * 0.7, height: 30,
                child: Text("# ${sehirtur}" , style: TextStyle(fontSize: 20, color: gir),)
            ),
          ],
        );
  }
  Row isim(double bosluk, Size size) {
    return Row(
          children: [
            SizedBox(width: bosluk,),
            SizedBox(
                width: size.width * 0.7, height: 50,
                child: Text(ad , style: TextStyle(fontSize: 35, color: gir),)
            ),
          ],
        );
  }

  Stack RCard(Size size, double radius, String resim, String ad, String tur, int kalp, int ziyaret) {
    return Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: size.height * 0.2, width: size.width * 0.8,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: aciksiya, width: 6),
            ),
          ),
          Positioned(
            bottom: 0, right: 5,
            child: Container(
              height: size.height * 0.175, width: size.width * 0.35,
              margin: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
                  color: aciksiya
              ),
            ),
          ),
          Positioned(
              top: 30, right: 30,
              child: Text(ad, style: TextStyle(fontSize: 30, color: gir, fontWeight: FontWeight.bold),)
          ),
          Positioned(
              top: 70, right: 30,
              child: Text(tur, style: TextStyle(fontSize: 20, color: gir, fontWeight: FontWeight.bold),)
          ),
          Positioned(
              bottom: 30, right: 25,
              child: Row(
                children: [
                  Icon(Icons.tour, size: 30, color: yesi,),
                  Text(ziyaret.toString(), style: TextStyle(fontSize: 30, color: yesi, fontWeight: FontWeight.w500),),
                ],
              )
          ),
        ]
    );
  }
}
class MyCustomClipper extends CustomClipper<Path> {
  double radius;

  MyCustomClipper(this.radius);
  @override
  Path getClip(Size size,) {
    final path = Path();
    path.lineTo(0, size.height - radius * 1.5);
    path.quadraticBezierTo(size.width/2, size.height * 0.9, size.width, size.height - radius * 1.5);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipper oldClipper) => false;

}