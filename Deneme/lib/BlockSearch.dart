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

class blockSearch extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: blocksearch(),
    );
  }
}
class blocksearch extends StatefulWidget {
  @override
  _blocksearchState createState() => _blocksearchState();
}
class _blocksearchState extends State<blocksearch> {

  List<List<dynamic>> Bloklar = [
    ["Blok Adı 1", "İstanbul", 4.5], ["Blok Adı 2", "Ankara", 2.5], ["Blok Adı 3", "İstanbul", 3.0], ["Blok Adı 4", "Ankara", 5.0],
    ["Blok Adı 5", "İzmir", 1.5], ["Blok Adı 6", "Trabzon", 3.2], ["Blok Adı 7", "Yozgat", 4.1], ["Blok Adı 8", "Bursa", 4.0],
    ["istanbul gezisi", "İzmit", 1.0], ["bursa gezisi", "Yozgat", 2.0], ["yaz gezisi", "Bursa", 1.5],
    ["tatil gezisi", "İstanbul", 2.5], ["turluyoruz1", "İstanbul", 4.0], ["ver elini yozgat", "Ankara", 1.0],
  ];

  bool filtrebool = false;
  String fsehir = "Ankara";
  List<double> fpuan = [0, 5];

  List<List<dynamic>> _foundUsers = [];
  List<List<dynamic>> filtre = [];

  @override
  initState() {_foundUsers = Bloklar; super.initState();}

  void _runFilter() {
    if(fsehir != null || fpuan != [0, 5])
      if(fsehir != null)
        Bloklar.forEach((element) {
          if(element[1] == fsehir && element[2] >= fpuan[0] && element[2] <= fpuan[1])
            filtre.add(element);
        });

      if(fsehir == null)
        Bloklar.forEach((element) {
          if(element[2] >= fpuan[0] && element[2] <= fpuan[1])
            filtre.add(element);
        });

    setState(() {_foundUsers = filtre;});
  }

  void _searchFilter(String enteredKeyword) {
    List<List<dynamic>> results = [];
    if(filtre.isNotEmpty)
      if (enteredKeyword.isEmpty) results = filtre;
      else results = filtre.where((sehir) => sehir[0].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    if(filtre.isEmpty)
      if (enteredKeyword.isEmpty) results = Bloklar;
      else results = Bloklar.where((sehir) => sehir[0].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();

    setState(() {_foundUsers = results;});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    double margin = 10;
    double radius = 25;

    List<Widget> blokCard = [];
    List<double> sort = [];
    List<double> terssort = [];
    _foundUsers.forEach((e) => sort.add(e[2]));
    sort.sort();
    for(int i = sort.length - 1; i >= 0; i--) terssort.add(sort[i]);
    terssort.forEach((x) {blokCard.add(BlokCard(size, margin, radius, _foundUsers.firstWhere((e) => e[2] == x)));});
    blokCard.reversed.toList();

    return Scaffold(
        backgroundColor: lacivert,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              ClipPath(
                clipper: MyCustomClipper(),
                child: Container(
                  color: siya,
                  width: size.width,
                  height: size.height * 0.3,
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.05,),
                  Stack(
                    alignment: Alignment.centerLeft,
                    children: [
                      Container(
                        width: size.width * 0.94, height: size.height * 0.085,
                        margin: EdgeInsets.all(margin),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(size.height * 0.05), color: lacivert),
                      ),
                      Positioned(
                        left: size.height * 0.005 + margin,
                        child: SizedBox(
                          width: size.width * 0.75,
                          child: TextFormField(
                            onChanged: (value) => _searchFilter(value),
                            decoration: InputDecoration(
                              fillColor: Colors.white,
                              filled: true,
                              labelText: "Hangi Blok",
                              prefixIcon: Icon(Icons.search),
                              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
                              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
                            ),
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.done,
                          ),
                        ),
                      ),
                      Positioned(
                        right: size.height * 0.005 + margin,
                        child: GestureDetector(
                          child: CircleAvatar(
                              radius: size.height * 0.035,
                              backgroundColor: sar,
                              child: Icon(Icons.filter_alt, size: 45, color: gr)
                          ),
                          onTap: (){filtrebool = !filtrebool; _runFilter();},
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.all(margin), padding: EdgeInsets.all(margin),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: gr),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.arrow_forward_ios_outlined, size: 25, color: koyugri),
                              onTap: (){},
                            ),
                            Text(fsehir, style: TextStyle(fontSize: 20, color: koyugri, fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.all(margin), padding: EdgeInsets.all(margin),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(radius), color: gr),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              child: Icon(Icons.arrow_forward_ios_outlined, size: 25, color: koyugri),
                              onTap: (){},
                            ),
                            Text("${fpuan[0]} - ${fpuan[1]}",
                              style: TextStyle(fontSize: 20, color: koyugri, fontWeight: FontWeight.bold),)
                          ],
                        ),
                      ),
                    ],
                  ),
                  Column(children: blokCard,)
                ],
              )
            ],
          ),
        )
    );
  }

  Container BlokCard(Size size, double margin, double radius, List<dynamic> Blok) {
    return Container(
      width: size.width * 0.9, height: 110,
      margin: EdgeInsets.all(margin),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        gradient: LinearGradient(
          colors: [sar, siya],
          begin: Alignment.bottomLeft,
          end: Alignment.bottomRight,
          stops: [0.13, 0.13],
        )
      ),
      child: Row(
        children: [
          SizedBox(width: size.width * 0.05,),
          Container(
            height: 90, width: size.width * 0.3,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage("server/istanbul.jpg"), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          SizedBox(width: size.width * 0.02,),
          SizedBox(
            width: size.width * 0.5,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  height: 70, width: size.width * 0.5,
                  child: Text(
                    Blok[0],
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold, color: gr),
                    textAlign: TextAlign.left, maxLines: 2,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("#${Blok[1]}", style: TextStyle(fontSize: 20, color: gr),),
                    Row(
                      children: [
                        Icon(Icons.star, size: 25, color: sar),
                        Text(Blok[2].toString(), style: TextStyle(fontSize: 17, color: gr),),
                      ],
                    )
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
class MyCustomClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size,) {
    final path = Path();
    path.lineTo(0, size.height - 96);
    path.quadraticBezierTo(9.6, size.height - 60, 48, size.height - 56);
    path.lineTo(size.width - 56, size.height - 56);
    path.quadraticBezierTo(size.width - 9.6, size.height - 48, size.width, size.height);
    path.lineTo(size.width, 0);
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipper oldClipper) => false;
}