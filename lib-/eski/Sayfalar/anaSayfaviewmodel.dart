import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/init/profilprovider.dart';
import 'package:flutter_app/init/themeprovider.dart';
import 'package:flutter_app/sqlfite/UserDatabase.dart';
import 'package:flutter_app/init/local_keys.g.dart';
import 'package:flutter_app/init/string_ext.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'anaSayfa.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/ayarlarSayfasi.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/profilSayfasi.dart';
import 'package:flutter_app/init/theme.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/server.dart';
import 'package:flutter/material.dart';
import 'planserver.dart';
import 'pprogramsayfa.dart';
import 'psehiraramasayfasi.dart';
import 'pseyehathazırlama.dart';
import 'dart:convert';
import 'dart:io';
import 'sehirhero.dart';

abstract class AnaSayfaviewmodel extends State<TemelSayfa> {
  final userHelper = UserDatabase.instance;
  final genelcon = GlobalKey<FormState>();
  final isimcon = TextEditingController();

  Color gri = Color(0xffbD6D6D6);
  bool tr = false;

  _profil(){
    if(Provider.of<CostumProfilData>(context).getProfilData['profil'] == null)
      return Container(
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Color(0xff30475E), width: 5)
          ),
          child: Icon(Icons.account_circle, color: Colors.grey,)
      );
    else return DisplayPictureScreen(imageAnalysed: Provider.of<CostumProfilData>(context).getProfilData['profil']);
  }

  bool dark = true;

  int g = DateTime.now().weekday - 1;
  int p = 0;
  int p2 = 0;

  String planAdi = 'Ankara Planı';
  DateTime planBas = DateTime(2021, 8, 6);
  DateTime planBit = DateTime(2021, 8, 15);
  List<List> planList = [];

  void bidirim(){
    if(genelcon.currentState.validate()){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context){
            return AlertDialog(
              title: Text(MekanMap[aktiveEvent[3]]['ad'], textAlign: TextAlign.center, style: TextStyle(fontSize: 30),),
              content: SingleChildScrollView(
                child: Text(MekanMap[aktiveEvent[3]]['tarih']),
              ),
              actions: [
                FlatButton(onPressed:() {setState(() {Navigator.pop(context);});},
                    child: Text('Tamam'))
              ],
            );
          }
      );
    }
  }

  int page = 2;

  Container PlanSayfa(Size size, List<Widget> Plancards) {
    return Container(
      child: Stack(children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/ekran4.PNG'), fit: BoxFit.cover)),
        ),
        Positioned(right: 0, child: Container(height: size.height, width: 40, color: theme().renk(theme().Sari, dark),),),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              PlanCard(0, p2, size.width, planAdi, planBas, planBit, planList, dark),
              Column(children: Plancards,),
            ],
          ),
        )
      ],
      ),
    );
  }

  Form AnaSayfa(Size size, List<String> ay, Widget gunlukPlan(), Widget guncard(int i, String gun)) {
    return Form(
      key: genelcon,
      child: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: size.width, height: size.height * 1.4, color: Colors.black,),
            Container(
              width: size.width, height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage('assets/images/ekran3.PNG'), fit: BoxFit.cover),
              ),
            ),
            Container(
              width: size.width, height: size.height,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.transparent, Colors.black],
                    stops: <double>[0.5, 0.95],
                  )
              ),
            ),
            //Provider.of<ProfilData>(context).getUserData['name']
            Merhaba('mesut'),
            Anlikharaket(size),
            Tarih(ay),
            Positioned(bottom: 90, left: 60, child: gunlukPlan()),
            GulukHareketler(size, guncard),
          ],
        ),
      ),
    );
  }
  Positioned Tarih(List<String> ay) {
    return Positioned(bottom: 600, left: 30,
        child: RichText(
          text: TextSpan(
              children: <TextSpan>[
                TextSpan(text: '${ay[DateTime.now().month - 1]}',
                  style: TextStyle(fontSize: 50, fontWeight: FontWeight.bold, color: Colors.lightBlue,),),
                TextSpan(text: ' , ', style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),),
                TextSpan(text: '${DateTime.now().year}',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, color: Color(0xffa5e65a)),),
              ]
          ),
        )
    );
  }
  Positioned GulukHareketler(Size size, Widget guncard(int i, String gun)) {
    return Positioned(bottom: 90, left: 4,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.08,),
          GestureDetector(
            child: guncard(0, localKeys.takvim_pzt.locale),
            onTap: (){setState(() {g = 0;selectevent = events[DateTime(2021, 8, 23)];});},
          ),
          SizedBox(height: 5,),
          GestureDetector(
            child: guncard(1, localKeys.takvim_sal.locale),
            onTap: (){setState(() {g = 1;selectevent = events[DateTime(2021, 8, 24)];});},
          ),
          SizedBox(height: 5,),
          GestureDetector(
            child: guncard(2, localKeys.takvim_car.locale),
            onTap: (){setState(() {g = 2;selectevent = events[DateTime(2021, 8, 25)];});},
          ),
          SizedBox(height: 5,),
          GestureDetector(
            child: guncard(3, localKeys.takvim_per.locale),
            onTap: (){setState(() {g = 3;selectevent = events[DateTime(2021, 8, 26)];});},
          ),
          SizedBox(height: 5,),
          GestureDetector(
            child: guncard(4, localKeys.takvim_cum.locale),
            onTap: (){setState(() {g = 4;selectevent = events[DateTime(2021, 8, 27)];});},
          ),
          SizedBox(height: 5,),
          GestureDetector(
            child: guncard(5, localKeys.takvim_cmt.locale),
            onTap: (){setState(() {g = 5;selectevent = events[DateTime(2021, 8, 28)];});},
          ),
          SizedBox(height: 5,),
          GestureDetector(
            child: guncard(6, localKeys.takvim_paz.locale),
            onTap: (){setState(() {g = 6;selectevent = events[DateTime(2021, 8, 29)];});},
          ),
        ],
      ),
    );
  }
  Positioned Anlikharaket(Size size) {
    return Positioned(top: 160, left: 30,
      child: Container(
          width: size.width * 0.85, height: 100,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme().renk(theme().Siyah, dark), width: 3),
              color: theme().renk(theme().aciksiyah, dark)
          ),
          child: Row(
            children: [
              SizedBox(width: 5),
              SizedBox(
                  width: size.width * 0.45,
                  child: Center(child: Text(aktiveEvent[0],
                    style: TextStyle(color: theme().renk(theme().Gri, dark), fontSize: 25),textAlign: TextAlign.center,),)
              ),
              Container(
                margin: EdgeInsets.all(5),
                width: 90,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: theme().renk(theme().Siyah, dark), width: 3),
                  image: DecorationImage(image: AssetImage(MekanMap[aktiveEvent[3]]['resim']), fit: BoxFit.cover),
                ),
              ),
              SizedBox(width: 5),
              GestureDetector(
                  child: Container(
                    width: 40, height: 100,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: theme().renk(theme().Gri, dark).withOpacity(0.8)
                    ),
                    child: Center(child: Icon(Icons.info_outline, size: 40, color: theme().renk(theme().aciksiyah, dark),)
                    ),
                  ),
                  onTap: (){bidirim();}
              )
            ],
          )
      ),
    );
  }
  Positioned Merhaba(String ad) {
    return Positioned(top: 100, left: 30,
        child: Text('${localKeys.anaSayfa_merhaba.locale},${ad}',
          style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),)
    );
  }

  Container SehirSayfa(Size size, BuildContext context, List<Widget> Itemcards) {
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
                SizedBox(height: 150,),
                SehirArama(size, context),
                SizedBox(height: 60,),
                Text(localKeys.sehirsayfasi_trendler.locale, style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: gri),),
                SizedBox(height: 20,),
                TrendSehirler(size),
                SizedBox(height: 60,),
                Text(localKeys.sehirsayfasi_sehirler.locale, style: TextStyle(fontSize: 30, fontStyle: FontStyle.italic, color: gri),),
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
  SizedBox TrendSehirler(Size size) {
    return SizedBox(height: 150,
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
    );
  }
  SizedBox SehirArama(Size size, BuildContext context) {
    return SizedBox(
      width: size.width *0.9,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: TextFormField(
          controller: isimcon,
          onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => Sehirarama()));},
          decoration: InputDecoration(
            fillColor: Colors.white,
            filled: true,
            labelText: localKeys.sehirsayfasi_sehiradi.locale,
            prefixIcon: Icon(Icons.search),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
          ),
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.done,
        ),
      ),
    );
  }

  AppBar AppBarMethod() {
    return AppBar(
      backgroundColor: Provider.of<CostumThemeData>(context).getThemeData.secondaryHeaderColor,
      actions: [
        //_profil(),
        SizedBox(width: 10,)
      ],
      centerTitle: true,
      title: Container(
        margin: EdgeInsets.all(10),
        child: Image.asset('assets/icons/logo.png'),
      ),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(30))
      ),
    );
  }
  Drawer DrawerMethod(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
            decoration: BoxDecoration(color: Provider.of<CostumThemeData>(context).getThemeData.secondaryHeaderColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                //_profil(),
                Text("mesut", style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
          draweTile(ad: 'Profil', icon: Icons.account_circle,
            ontap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ProfilePage()));},
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.blueAccent))
              ),
              child: InkWell(
                splashColor: Colors.blueAccent,
                onTap: (){setState(() {
                  dark = !dark;
                  dark ? Provider.of<CostumThemeData>(context, listen: false).setThemeData(lighttheme) :
                  Provider.of<CostumThemeData>(context, listen: false).setThemeData(darktheme);});},
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
                      Switch(value: dark, onChanged: (val){setState(() {
                        dark = val;
                        val ? Provider.of<CostumThemeData>(context, listen: false).setThemeData(lighttheme) :
                        Provider.of<CostumThemeData>(context, listen: false).setThemeData(darktheme);
                      });}),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 0, 8.0, 0),
            child: Container(
              decoration: BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.blueAccent))
              ),
              child: InkWell(
                splashColor: Colors.blueAccent,
                onTap: (){setState(() {
                  tr = !tr;
                  context.locale = tr ? Locale("tr","TR") : Locale("en","US");
                });},
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
                            child: Text(context.locale.languageCode ,style: TextStyle(fontSize: 16.0),),)
                        ],
                      ),
                      Switch(value: tr, onChanged: (val){
                        setState(() {context.locale = val ? Locale("tr","TR") : Locale("en","US"); tr = val;});
                      }),
                    ],
                  ),
                ),
              ),
            ),
          ),
          draweTile(ad: 'İletişim', icon: Icons.call,
            ontap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => ContactPage()));},
          ),
          draweTile(ad: 'Çıkış', icon: Icons.highlight_off, ontap: (){},),
        ],
      ),
    );
  }
  Container BottomNavigationBarMethod(Size size, BuildContext context) {
    return Container(
      width: size.width,
      color: Colors.transparent,
      height: 80,
      child: Stack(children: [
        CustomPaint(size: Size(size.width, 80), painter: altbuton(renk: Provider.of<CostumThemeData>(context).getThemeData.secondaryHeaderColor),),
        Center(
          heightFactor: 0.6,
          child: FloatingActionButton(
            onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SeyehatHaz()));print('geçmek');},
            backgroundColor: Provider.of<CostumThemeData>(context).getThemeData.secondaryHeaderColor,
            child: Icon(Icons.add_circle_outline_outlined, size: 50, color: Provider.of<CostumThemeData>(context).getThemeData.scaffoldBackgroundColor),
            elevation: 0.1,
          ),
        ),
        Container(
          width: size.width,
          height: 80,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              IconButton(icon: Icon(Icons.map, size: 40, color: Provider.of<CostumThemeData>(context).getThemeData.scaffoldBackgroundColor,),
                  onPressed: (){setState(() {page = 0;});}
              ),
              IconButton(icon: Icon(Icons.apartment_rounded, size: 40, color: Provider.of<CostumThemeData>(context).getThemeData.scaffoldBackgroundColor,),
                  onPressed: (){setState(() {page = 1;});}
              ),
              Container(width: size.width*0.2,),
              IconButton(icon: Icon(Icons.home, size: 40, color: Provider.of<CostumThemeData>(context).getThemeData.scaffoldBackgroundColor,),
                  onPressed: (){setState(() {page = 2;});}
              ),
              IconButton(icon: Icon(Icons.account_balance_rounded, size: 40, color: Provider.of<CostumThemeData>(context).getThemeData.scaffoldBackgroundColor,),
                  onPressed: (){setState(() {page = 3;});}
              ),
            ],),
        )
      ],),
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

class DisplayPictureScreen extends StatefulWidget {
  final String imageAnalysed;
  const DisplayPictureScreen({Key key, this.imageAnalysed}) : super(key: key);

  @override
  _DisplayPictureScreenState createState() => _DisplayPictureScreenState();
}
class _DisplayPictureScreenState extends State<DisplayPictureScreen> {
  File fileImg;
  bool isLoading = true;

  void writeFile() async {
    final decodedBytes = base64Decode(widget.imageAnalysed);
    final directory = await getApplicationDocumentsDirectory();
    fileImg = File('${directory.path}/Image.png');
    print(fileImg.path);
    fileImg.writeAsBytesSync(List.from(decodedBytes));

    setState(() {
      isLoading = false;
    });
  }

  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((_){
      writeFile();
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isLoading ? CircularProgressIndicator() : Container(
      width: 60, height: 60,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: Color(0xff30475E), width: 5),
          image: DecorationImage(image: FileImage(fileImg), fit: BoxFit.cover)
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

class PlanCard extends StatelessWidget {
  int i;
  int g;
  double w;
  String planAdi;
  DateTime planBas;
  DateTime planBit;
  List<List> planList;
  bool dark;

  PlanCard(this.i, this.g, this.w, this.planAdi, this.planBas, this.planBit, this.planList, this.dark);

  @override
  Widget build(BuildContext context) {
    if(i == g){
      return Stack(
        children: [
          Container(height: 120, width: w,),
          Positioned(right: 0,
            child: Container(
              height: 120, width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(60)),
                color: theme().renk(theme().Sari, dark),
              ),
            ),
          ),
          Positioned(left: 20, top: 15,
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Text(planAdi, style: TextStyle(fontSize: 35, color: theme().renk(theme().aciksiyah, dark)),),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(DateFormat.yMMMd().format(planBas),
                      style: TextStyle(fontSize: 23, color: theme().renk(theme().Yesil, dark)),),
                    SizedBox(width: 10,),
                    Text(DateFormat.yMMMd().format(planBit),
                      style: TextStyle(fontSize: 23, color: theme().renk(theme().Kirmizi, dark)),),
                  ],
                )
              ],
            ),
          ),
          Positioned(right: 40, top: 35,
              child: GestureDetector(
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: theme().renk(theme().aciksiyah, dark),
                  child: Icon(Icons.info_outline, size: 50, color: theme().renk(theme().Gri, dark),),
                ),
                onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProgramSayfasi()));},
              )
          ),
        ],
      );
    }
    else{
      return Stack(
        children: [
          Container(height: 80, width: w,),
          Positioned(right: 0,
            child: GestureDetector(
              child: Container(height: 120, width: 40, color: theme().renk(theme().Sari, dark),),
              onTap: (){},
            ),
          ),
          Positioned(right: 50, top: 40, child: Text(planAdi,
            style: TextStyle(fontSize: 30, color: theme().renk(theme().Sari, dark), fontWeight: FontWeight.bold),),),
          Positioned(right: 10, top: 50, child: Icon(Icons.circle, size: 20, color: theme().renk(theme().aciksiyah, dark),)),
        ],
      );
    }
  }
}