import 'dart:convert';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Sayfalar/server.dart';
import 'package:flutter_app/sqlfite/resimlerDatabase.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'planserver.dart';

class ProgramSayfasi extends StatefulWidget {

  @override
  _ProgramSayfasiState createState() => _ProgramSayfasiState();
}
class _ProgramSayfasiState extends State<ProgramSayfasi> {
  double w = 420;

  Color siyah = Color(0xff202020);
  Color aciksiyah = Color(0xff333533);
  Color gri = Color(0xffD6D6D6);

  @override
  void initState() {
    listeolusturma();
    super.initState();
  }

  final galeriHelper = ResimDatabase.instance;
  List<String> resimler = [];
  _openCam(BuildContext context) async {
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    resimkaydetme(picture);
  }
  listeolusturma() async {
    List<Map<String, dynamic>> resim = await galeriHelper.getList();
    resimler.clear();
    for(int i = 0; i < resim.length; i ++){
      if(resim[i][galeriHelper.columnPlan] == planlar[1]["ad"]){
        resimler.add(resim[i][galeriHelper.columnResim]);
      }
    }
  }
  resimkaydetme(File resimfile)async{
    List<int> imageBytes = resimfile.readAsBytesSync();
    print(imageBytes);
    String base64Image = base64Encode(imageBytes);
    Map<String, dynamic> row = {
      galeriHelper.columnPlan : planlar[1]["ad"],
      galeriHelper.columnResim : base64Image,
    };
    await galeriHelper.insert(row);
    listeolusturma();
    setState(() {});
  }
  
  int _page = 0;
  @override
  Widget build(BuildContext context) {
    print(Ankaraplani[1]["baslangic"]);
    List<Widget> HaraketCards = [];
    for(int i = 0; i < Ankaraplani.length; i++)
      HaraketCards.add(HaraketCard(w: w, date: DateTime.parse(Ankaraplani[i]["baslangic"]), icon: eveticon[Ankaraplani[i]["icon"]],
          bina: Ankaraplani[i]["yer"], haraket: Ankaraplani[i]["haraket"]),);

    List<Widget> Images = [];
    for(int i = 0; i < resimler.length; i++)
      Images.add(DisplayPictureScreen(imageAnalysed: resimler[i],));

    final pages = [
      Column(children: HaraketCards),
      Container(
        width: 400, color: Color(0xff30475E),
        child: Column(
          children: [
            Container(
              width: 400, height: 80, color: Color(0xff30475E),
              child: Center(
                child: GestureDetector(
                  child: Container(
                    width: 180, height: 60,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(30), color: aciksiyah,),
                    child: Row(
                      children: [
                        SizedBox(width: 10,),
                        Icon(Icons.camera_alt, size: 30, color: gri,),
                        SizedBox(width: 10,),
                        Text('Camera', style: TextStyle(fontSize: 30, color: gri,),)
                      ],
                    ),
                  ),
                  onTap: (){_openCam(context);},
                )
              ),
            ),
            resimler == null ? Center(child: Text('Hiç resim yok', style: TextStyle(fontSize: 30),),) :
                Wrap(
                  children: Images,
                )
          ],
        )
      ),
    ];

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        extendBodyBehindAppBar: true,
        backgroundColor: Color(0xff30475E),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          flexibleSpace: Stack(
            children: [
              Container(
                margin: EdgeInsets.all(5),
                height: 80,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: siyah,),
                child: Center(child: Text(planlar[1]["ad"], style: TextStyle(color: Color(0xffa5e65a), fontSize: 50),),),
              ),
              Positioned(left: 5, top: 10,
                child: IconButton(
                  icon: Icon(Icons.arrow_back, size: 40, color: gri,),
                  onPressed: (){Navigator.pop(context);},),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    width: w + 20, height: w * 0.7,
                    decoration: BoxDecoration(
                        image: DecorationImage(image: AssetImage(MekanMap[planlar[1]["baslangicsehir"]]['resim']), fit: BoxFit.cover)
                    ),
                  ),
                  ClipPath(
                    clipper: ImageClipper(),
                    child: Container(
                      width: w, height: w * 0.7,
                      decoration: BoxDecoration(
                          image: DecorationImage(image: AssetImage(MekanMap[planlar[1]["bitissehir"]]['resim']), fit: BoxFit.cover)
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 0, right: 0,
                    child: Container(
                      width: w,
                      child: Row(
                        children: [
                          Spacer(flex: 2,),
                          GestureDetector(
                            child: Container(
                              width: 140, height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20), color: aciksiyah
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Events', style: TextStyle(fontSize: 30, color: gri,),),
                                  Container(width: 60, height: 4, color: gri,)
                                ],
                              ),
                            ),
                            onTap: (){setState(() {_page = 0;});},
                          ),
                          Spacer(flex: 1,),
                          GestureDetector(
                            child: Container(
                              width: 140, height: 50,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20), color: aciksiyah
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text('Galery', style: TextStyle(fontSize: 30, color: gri,),),
                                  Container(width: 60, height: 4, color: gri,)
                                ],
                              ),
                            ),
                            onTap: (){setState(() {_page = 1;});},
                          ),
                          Spacer(flex: 2,),
                        ],
                      ),
                    ),
                  )
                ],
              ),
              pages[_page],
            ],
          ),
        ),
      ),
    );
  }
}
class ImageClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path();
    path.lineTo(0.0, size.height);
    path.lineTo(100.0, size.height);
    path.lineTo(size.width / 2 + 100, 0.0);
    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) => false;
}
class HaraketCard extends StatelessWidget {
  double w;
  DateTime date;
  IconData icon;
  String bina;
  String haraket;
  HaraketCard({this.w, this.date, this.icon, this.bina, this.haraket});

  Color siyah = Color(0xffb202020);
  Color aciksiyah = Color(0xffb333533);
  Color gri = Color(0xffbD6D6D6);
  Color aciksari = Color(0xffbFFEE32);
  Color sari = Color(0xffbFFD100);
  Color kirmizi = Color(0xffbDB3A34);
  Color yesil = Color(0xffb709C09);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(width: w, height: 120, color: Color(0xff30475E),),
        Positioned(top: 60, left: 0,
          child: Text('${date.hour}.${date.minute}',
            style: TextStyle(fontSize: 35, color: Color(0xffC6DE41), fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(top: 10, left: 0,
          child: Text('${date.month}/${date.day}',
            style: TextStyle(fontSize: 25, color: aciksiyah, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(top: 0, left: 100,
            child: Container(
              width: 8, height: 120, color: yesil,
            )
        ),
        Positioned(top: 10, left: 80,
          child: CircleAvatar(radius: 25, child: Icon(icon, size: 30, color: aciksari,), backgroundColor: aciksiyah,),
        ),
        Positioned(top: 15, left: 140,
          child: Container(
            height: 90, width: 90,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/images/anitkabir2.jpg'), fit: BoxFit.cover),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(width: 5, color: Color(0xff222831))
            ),
          )
        ),
        Positioned(top: 20, left: 240,
          child: SizedBox(
            width: 150,
            child: Text(haraket,
              style: TextStyle(fontSize: 20, color: Color(0xffFCA311), fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
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
      height: 180, width: 160,
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xff222831), width: 3),
          image: DecorationImage(image: FileImage(fileImg), fit: BoxFit.cover)
      ),
    );
  }
}


