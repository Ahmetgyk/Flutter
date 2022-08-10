import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'SehirBilgi.dart';
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

class SearhCity extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: searchCity(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class searchCity extends StatefulWidget {

  @override
  _searchCityState createState() => _searchCityState();
}

bool searchbool = false;

class _searchCityState extends State<searchCity> {

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 0, 'mekan' : 'İstanbul'},
    {"id": 1, 'mekan' : 'İzmir'},
    {"id": 2, 'mekan' : 'Kahramanmaraş'},
    {"id": 0, 'mekan' : 'İstanbul'},
    {"id": 1, 'mekan' : 'İzmir'},
    {"id": 2, 'mekan' : 'Kahramanmaraş'},
  ];

  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    _foundUsers = _allUsers;
    super.initState();
  }

  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user['mekan'].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
    }

    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double radius = 30;
    double margin = 10;
    double bosluk = 20;

    List<Widget> trendler = [];
    for(int i = 0; i < 2; i++){
      for(int i = 0; i < TrendSehir.length; i++)
        for(int e = 0; e < Sehirler.length; e++)
          if(Sehirler[e]["isim"] == TrendSehir[i]){
            if(StarSehirler.any((a) => a.contains(Sehirler[e]["isim"])))
              trendler.add(TrendCard(size, radius, Sehirler[e]["resim"], Sehirler[e]["isim"],
                  Sehirler[e]["tür"], Sehirler[e]["kalp"], Sehirler[e]["ziyaret"], true));
            else
              trendler.add(TrendCard(size, radius, Sehirler[e]["resim"], Sehirler[e]["isim"],
                  Sehirler[e]["tür"], Sehirler[e]["kalp"], Sehirler[e]["ziyaret"], false));
          }
    }

    List<Widget> mekanlar = [];
    for(int i = 0; i < 2; i++){
      for(int j = 0; j < Sehirler.length; j++){
        if(StarSehirler.any((e) => e.contains(Sehirler[j]["isim"])))
          mekanlar.add(SehirCard(size, radius, margin, bosluk, Sehirler[j]["isim"], Sehirler[j]["tür"], Sehirler[j]["resim"],
              Sehirler[j]["hava"], Sehirler[j]["ziyaret"], Sehirler[j]["kalp"], Sehirler[j]["tarih"], Sehirler[j]["benzerler"],
              Sehirler[j]["mekanlar"], Sehirler[j]["mesajlar"], true));
        else
          mekanlar.add(SehirCard(size, radius, margin, bosluk, Sehirler[j]["isim"], Sehirler[j]["tür"], Sehirler[j]["resim"],
              Sehirler[j]["hava"], Sehirler[j]["ziyaret"], Sehirler[j]["kalp"], Sehirler[j]["tarih"], Sehirler[j]["benzerler"],
              Sehirler[j]["mekanlar"], Sehirler[j]["mesajlar"], false));
      }
    }

    List<Widget> findcity = List.generate(_foundUsers.length, (i) => FindCard(size, radius, Sehirler[_foundUsers[i]["id"]]["resim"], Sehirler[_foundUsers[i]["id"]]["isim"],
        Sehirler[_foundUsers[i]["id"]]["tür"], Sehirler[_foundUsers[i]["id"]]["kalp"], Sehirler[_foundUsers[i]["id"]]["ziyaret"]));

    // List<Widget> findcity = [];
    // for(int i = 0; i < _foundUsers.length; i++){
    //   findcity.add(FindCard(size, radius, Sehirler[_foundUsers[i]["id"]]["resim"], Sehirler[_foundUsers[i]["id"]]["isim"],
    //       Sehirler[_foundUsers[i]["id"]]["tür"], Sehirler[_foundUsers[i]["id"]]["kalp"], Sehirler[_foundUsers[i]["id"]]["ziyaret"]));
    // }

    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: size.width,
          color: siya,
          child: Yuklendi(size, findcity, trendler, mekanlar),
          //child: Yukleme(size, radius, margin, bosluk),
        ),
      ),
    );
  }

  Column Yukleme(Size size, double radius, double margin, double bosluk,) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.1,),
        Row(
          children: [
            SizedBox(width: 10,),
            Container(
              width: size.width * 0.85, height: size.height * 0.1,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.width * 0.4), color: beyaz),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.02,),
        Row(
          children: [
            SizedBox(width: 20,),
            Container(
              width: size.width * 0.8, height: 50,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(25), color: lacivert),
            ),
          ],
        ),
        Container(height: size.height * 0.3, width: size.width,
          child: SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(children: [yoTrendCard(size, radius), yoTrendCard(size, radius),]),
          ),
        ),
        Row(
          children: [
            SizedBox(width: 20,),
            Container(
              width: size.width * 0.7, height: 40,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: lacivert),
            ),
          ],
        ),
        SizedBox(height: size.height * 0.01,),
        Column(children: [yoSehirCard(size, radius, margin, bosluk), yoSehirCard(size, radius, margin, bosluk),]),
      ],
    );
  }
  Stack yoSehirCard(Size size, double radius, double margin, double bosluk,){
    return Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: size.height * 0.28, width: size.width * 0.9,
            margin: EdgeInsets.all(size.width * 0.04),
            decoration: BoxDecoration(
              color: aciksiya,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: lacivert, width: 6),
              boxShadow: [
                BoxShadow(
                    spreadRadius: -4,
                    blurRadius: 25,
                    offset: Offset(7, 17),
                    color: Colors.black)
              ],
            ),
          ),
          Positioned(
              bottom: size.height * 0.02, right: size.width * 0.04,
              child: RotatedBox(
                quarterTurns: 2,
                child: ClipPath(
                  clipper: MyCustomClipper(radius),
                  child: Container(
                    color: lacivert,
                    width: size.width * 0.9,
                    height: size.height * 0.105,
                  ),
                ),
              )
          ),
          Positioned(
            bottom: size.height * 0.03, right: size.width * 0.41,
            child: CircleAvatar(backgroundColor: sar, radius: 33,),
          ),
          Positioned(
            top: 30, right: 30,
            child: CircleAvatar(
              backgroundColor: gr,
              radius: 23,
            ),
          ),
        ]
    );
  }
  Stack yoTrendCard(Size size, double radius,) {
    return Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: size.height * 0.2, width: size.width * 0.8,
            margin: EdgeInsets.all(size.width * 0.04),
            decoration: BoxDecoration(
              color: aciksiya,
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: lacivert, width: 6),
              boxShadow: [
                BoxShadow(
                    spreadRadius: -4,
                    blurRadius: 25,
                    offset: Offset(7, 17),
                    color: Colors.black)
              ],
            ),
          ),
          Positioned(
            bottom: 0, right: 0,
            child: Container(
              height: size.height * 0.2, width: size.width * 0.35,
              margin: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: lacivert
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.08, right: size.width * 0.33,
            child: CircleAvatar(
              backgroundColor: sar,
              radius: 30,
            ),
          ),
          Positioned(
            bottom: 30, left: 30,
            child: CircleAvatar(
              backgroundColor: gr,
              radius: 20,
            ),
          ),
        ]
    );
  }

  Column Yuklendi(Size size, List<Widget> findcity, List<Widget> trendler, List<Widget> mekanlar) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: size.height * 0.1,),
        SizedBox(
          width: size.width,
          child: Row(
            children: [
              Container(
                width: size.width *0.85, height: size.height * 0.1,
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  onTap: (){searchbool = true;},
                  onChanged: (value) => _runFilter(value),
                  onFieldSubmitted: (value) {searchbool = false;},
                  decoration: InputDecoration(
                    fillColor: Colors.white,
                    filled: true,
                    labelText: "Hangi Şehir",
                    prefixIcon: Icon(Icons.search),
                    enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
                    focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                ),
              ),
              searchbool? GestureDetector(
                child: CircleAvatar(
                    radius: 25,
                    backgroundColor: lacivert.withOpacity(0.8),
                    child: Icon(Icons.arrow_back, size: 45, color: beyaz.withOpacity(0.8))
                ),
                onTap: (){setState(() {searchbool = false;});},
              ) : Container(),
            ],
          ),
        ),
        SizedBox(height: size.height * 0.02,),
        searchbool ? Find(size, findcity) : Search(size, trendler, mekanlar)
      ],
    );
  }

  Widget Find(Size size, List<Widget> findcity){
    return _foundUsers.length > 0
        ? Container(
            height: size.height * 0.79,
            child: SingleChildScrollView(child: Column(children: findcity,)))
        : Container(
            height: size.height * 0.79,
            child: Center(child: Text('Öğe bulunamadı', style: TextStyle(fontSize: 24, color: Color(0xffDDDDDD))))
    );
  }
  Column Search(Size size, List<Widget> trendler, List<Widget> mekanlar) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: 20,),
              Text("Bunları Beğenebilirsiniz", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: gir),),
            ],
          ),
          Container(height: size.height * 0.3, width: size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: trendler,),
            ),
          ),
          Row(
            children: [
              SizedBox(width: 20,),
              Text("Şehirler", style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: gir),),
            ],
          ),
          SizedBox(height: size.height * 0.01,),
          Column(children: mekanlar,),
        ],
      );
  }
  
  Stack SehirCard(Size size, double radius, double margin, double bosluk, String ad, String tur, String resim, List<dynamic> havadurumu,
      int ziyaret, int kalp, String tarih, List<String> benzerler, List<String> mekanlar, List<dynamic> mesajlar, bool star){
    return Stack(
      overflow: Overflow.visible,
      children: [
        Hero(
          tag: ad,
          child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
                height: size.height * 0.28, width: size.width * 0.9,
                margin: EdgeInsets.all(size.width * 0.04),
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(radius),
                  border: Border.all(color: lacivert, width: 6),
                  boxShadow: [
                    BoxShadow(
                        spreadRadius: -4,
                        blurRadius: 25,
                        offset: Offset(7, 17),
                        color: Colors.black)
                  ],
                ),
              ),
            Positioned(
                bottom: size.height * 0.02, right: size.width * 0.04,
                child: RotatedBox(
                  quarterTurns: 2,
                  child: ClipPath(
                    clipper: MyCustomClipper(radius),
                    child: Container(
                      color: lacivert,
                      width: size.width * 0.9,
                      height: size.height * 0.105,
                    ),
                  ),
                )
              ),
            Positioned(
                bottom: size.height * 0.03, right: size.width * 0.41,
                child: GestureDetector(
                  onTap: ()=> Navigator.push(context,
                      MaterialPageRoute(builder: (context)=> sehirbilgi(radius, margin, bosluk, ad, tur,
                          resim, havadurumu, ziyaret, kalp, tarih, benzerler, mekanlar, mesajlar))),
                  child: CircleAvatar(
                    backgroundColor: sar,
                    radius: 33,
                    child: Center(
                        child: Icon(Icons.search_rounded, size: 40, color: gir,)
                    ),
                  ),
                ),
              ),
            Positioned(
                top: 30, right: 30,
                child: GestureDetector(
                  onTap: (){
                    setState(() {
                      if(star)
                        StarSehirler.remove(ad);
                      else
                        StarSehirler.add(ad);
                    });
                  },
                  child: CircleAvatar(
                    backgroundColor: gr,
                    radius: 23,
                    child: Center(
                      child: Icon(star ? Icons.star_outlined : Icons.star_border, size: 45, color: sar,),
                    ),
                  ),
                ),
              ),
            ]
          ),
        ),
          Positioned(
                top: 30, left: 40,
                child: Text(ad, style: TextStyle(fontSize: 30, color: gir, fontWeight: FontWeight.bold),)
            ),
          Positioned(
                top: 70, left: 40,
                child: Text(tur, style: TextStyle(fontSize: 20, color: gir, fontWeight: FontWeight.bold),)
            ),
          Positioned(
                bottom: 20, right: 25,
                child: Row(
                  children: [
                    Icon(Icons.tour, size: 30, color: yesi,),
                    Text(kalp.toString(), style: TextStyle(fontSize: 30, color: yesi, fontWeight: FontWeight.w500),),
                  ],
                )
            ),
          Positioned(
                bottom: 20, left: 30,
                child: Row(
                  children: [
                    Text(ziyaret.toString(), style: TextStyle(fontSize: 30, color: kirmiz, fontWeight: FontWeight.w500),),
                    Icon(Icons.favorite, size: 30, color: kirmiz,),
                  ],
                )
            ),
      ]
    );
  }
  Stack TrendCard(Size size, double radius, String resim, String ad, String tur, int kalp, int ziyaret, bool star) {
    return Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: size.height * 0.2, width: size.width * 0.8,
            margin: EdgeInsets.all(size.width * 0.04),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: lacivert, width: 6),
              boxShadow: [
                BoxShadow(
                    spreadRadius: -4,
                    blurRadius: 25,
                    offset: Offset(7, 17),
                    color: Colors.black)
              ],
            ),
          ),
          Positioned(
            bottom: 0, right: 0,
            child: Container(
              height: size.height * 0.2, width: size.width * 0.35,
              margin: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: lacivert
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.08, right: size.width * 0.33,
            child: CircleAvatar(
              backgroundColor: sar,
              radius: 30,
              child: Center(
                  child: Icon(Icons.search_rounded, size: 40, color: gir,)
              ),
            ),
          ),
          Positioned(
            bottom: 30, left: 30,
            child: GestureDetector(
              onTap: (){
                setState(() {
                  if(star)
                    StarSehirler.remove(ad);
                  else
                    StarSehirler.add(ad);
                });
              },
              child: CircleAvatar(
                backgroundColor: gr,
                radius: 20,
                child: Center(
                  child: Icon(star ? Icons.star_outlined : Icons.star_border, size: 40, color: sar,),
                ),
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
  Stack FindCard(Size size, double radius, String resim, String ad, String tur, int kalp, int ziyaret) {
    return Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: size.height * 0.2, width: size.width * 0.95,
            margin: EdgeInsets.all(size.width * 0.02),
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: lacivert, width: 6),
              boxShadow: [
                BoxShadow(
                    spreadRadius: -4,
                    blurRadius: 25,
                    offset: Offset(7, 17),
                    color: Colors.black)
              ],
            ),
          ),
          Positioned(
            bottom: -8, right: -3,
            child: Container(
              height: size.height * 0.2, width: size.width * 0.35,
              margin: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: lacivert
              ),
            ),
          ),
          Positioned(
            bottom: size.height * 0.075, right: size.width * 0.34,
            child: CircleAvatar(
              backgroundColor: sar,
              radius: 30,
              child: Center(
                  child: Icon(Icons.search_rounded, size: 40, color: gir,)
              ),
            ),
          ),
          Positioned(
              top: 25, right: 25,
              child: Text(ad, style: TextStyle(fontSize: 30, color: gir, fontWeight: FontWeight.bold),)
          ),
          Positioned(
              top: 70, right: 25,
              child: Text(tur, style: TextStyle(fontSize: 20, color: gir, fontWeight: FontWeight.bold),)
          ),
          Positioned(
              bottom: 30, right: 20,
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
    path.lineTo(size.width, radius);
    path.quadraticBezierTo(size.width, 0, size.width - radius, 0);
    path.lineTo(radius, 0);
    path.quadraticBezierTo(0, 0, 0, radius);
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipper oldClipper) => false;

}