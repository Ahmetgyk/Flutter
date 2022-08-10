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

class BlokSayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: blokSayfa(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class blokSayfa extends StatefulWidget {
  @override
  _blokSayfaState createState() => _blokSayfaState();
}

double height = 55;

class _blokSayfaState extends State<blokSayfa> {

  final blokcon = TextEditingController();

  String ozet = "arasındaki çoğunlukta olmakla birlikte hemen hemen 24 Oğuz boyunun tamamı mevcuttur.2012'de çıkarılan 6360 sayılı kanun ile büyükşehir olmuştur. Aynı zamanda il sınırları içerisinde bulunan Afşin - Elbistan A, B, C termik santralleri sayesinde Kahramanmaraş, Türkiye'nin elektrik ihtiyacının %14'ünü karşılamaktadır.[4]Döv";
  // 0 = yazı / 1 = resim
  List<List<dynamic>> blokdata = [
    [0, "Kahramanmaraş, arasındaki çoğunlukta olmakla birlikte hemen hemen 24 Oğuz boyunun tamamı mevcuttur.2012'de çıkarılan 6360 sayılı kanun ile büyükşehir olmuştur. Aynı zamanda il sınırları içerisinde bulunan Afşin - Elbistan A, B, C termik santralleri sayesinde Kahramanmaraş, Türkiye'nin elektrik ihtiyacının %14'ünü karşılamaktadır.[4]Dövme dondurması, tarhanası ve biberi şehrin önemli tescilli gıdalarıdır. 2021 itibarıyla %1,22 artarak 1.168.163 nüfusa ulaşmıştır.[5]",],
    [0, "Kahramanmaraş, arasındaki çoğunlukta olmakla birlikte hemen hemen 24 Oğuz boyunun tamamı mevcuttur.2012'de çıkarılan 6360 sayılı kanun ile büyükşehir olmuştur. Aynı zamanda il sınırları içerisinde bulunan Afşin - Elbistan A, B, C termik santralleri sayesinde Kahramanmaraş, Türkiye'nin elektrik ihtiyacının %14'ünü karşılamaktadır.[4]Dövme dondurması, tarhanası ve biberi şehrin önemli tescilli gıdalarıdır",],
    [1, "server/kahramanmaraş.jpg",],
    [0, "Türkidir ve ekseriya halkı Türkmendir der.[3] Maraş ve çevresi başta Oğuzların Avşar, Bayat ve Beğdili boyları çoğunlukta olmakla birlikte hemen hemen 24 Oğuz boyunun tamamı mevcuttur.2012'de çıkarılan 6360 sayılı kanun ile büyükşehir olmuştur. Aynı zamanda il sınırları içerisinde bulunan Afşin - Elbistan A, B, C termik santralleri sayesinde Kahramanmaraş, Türkiye'nin elektrik ihtiyacının %14'ünü karşılamaktadır.[4]Dövme dondurması, tarhanası ve biberi şehrin önemli tescilli gıdalarıdır. 2021 itibarıyla %1,22 artarak 1.168.163 nüfusa ulaşmıştır.[5]",],
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double bosluk = 20;
    double margin = 10;
    double radius = 25;

    List<Widget> blokcell = [];
    for(int i = 0; i < blokdata.length; i++) {
      if(blokdata[i][0] == 0){
        if(i == 0)
          blokcell.add(blokyazi(bosluk, size, blokdata[i][1]));
        if(i == blokdata.length - 1)
          blokcell.add(blokyazi(bosluk, size, blokdata[i][1]));
        if(i != 0 && i != blokdata.length - 1)
          blokcell.add(blokyazi(bosluk, size, blokdata[i][1]));
      }
      if(blokdata[i][0] == 1){
        if(i == 0)
          blokcell.add(blokresim(size, margin, blokdata[i][1]));
        if(i == blokdata.length - 1)
          blokcell.add(blokresim(size, margin, blokdata[i][1]));
        if(i != 0 && i != blokdata.length - 1)
          blokcell.add(blokresim(size, margin, blokdata[i][1]));
      }
    }

    return Scaffold(
      backgroundColor: siya,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: size.height * 0.5, width: size.width,
              decoration: BoxDecoration(
                image: DecorationImage(image: AssetImage("server/istanbul.jpg"), fit: BoxFit.cover),
                borderRadius: BorderRadius.circular(radius),
              ),
            ),
            ClipPath(
              clipper: MyCustomClipper(),
              child: Container(
                width: size.width, height: size.height * 0.5,
                color: siya,
              ),
            ),
            Column(
              children: [
                SizedBox(height: 60,),
                Container(
                  width: size.width - 2 * margin,
                  padding: EdgeInsets.all(margin),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Hero(
                        tag: "Blok isimi",
                        child: Text("İstanbul turu", style: TextStyle(color: gr, fontSize: 45, fontWeight: FontWeight.bold),),
                      ),
                      SizedBox(height: bosluk,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            child: Icon(Icons.account_circle, size: 30, color: gr,),
                            radius: 15,
                          ),
                          SizedBox(width: bosluk / 2,),
                          Text("Çiçek Özata", style: TextStyle(color: gr, fontSize: 25, fontWeight: FontWeight.bold),),
                        ],
                      ),
                      SizedBox(height: bosluk),
                      Text("İstanbul", style: TextStyle(color: gr, fontSize: 25, fontWeight: FontWeight.bold),),
                      SizedBox(height: bosluk),
                      Row(
                        children: [
                          Icon(Icons.star, size: 30, color: sar,),
                          Icon(Icons.star, size: 30, color: sar,),
                          Icon(Icons.star, size: 30, color: sar,),
                          Icon(Icons.star_half, size: 30, color: sar,),
                          Icon(Icons.star_outline_sharp, size: 30, color: sar,),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: size.height * 0.06,),
                Container(
                  width: size.width * 0.95,
                  margin: EdgeInsets.only(left: margin, right: margin,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radius), bottom: Radius.circular(radius)),
                    color: lacivert,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: bosluk),
                      SizedBox(
                        width: size.width * 0.8,
                        child: Text("Özet", style: TextStyle(fontSize: 30, color: gir, fontWeight: FontWeight.bold), textAlign: TextAlign.left,)
                      ),
                      SizedBox(height: bosluk / 2,),
                      SizedBox(
                          width: size.width * 0.8,
                          child: Text(ozet, style: TextStyle(fontSize: 20, color: gir),)
                      ),
                      SizedBox(height: bosluk),
                    ],
                  ),
                ),
                SizedBox(height: bosluk / 2,),
                Container(
                  width: size.width * 0.95,
                  margin: EdgeInsets.only(left: margin, right: margin,),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(radius), bottom: Radius.circular(radius)),
                    color: lacivert,
                  ),
                  child: Column(
                    children: [
                      SizedBox(height: bosluk),
                      Column(children: blokcell,),
                      SizedBox(height: bosluk),
                    ],
                  ),
                ),
                Container(
                  width: size.width,
                  height: height,
                  decoration: BoxDecoration(
                    color: koyugri,
                    boxShadow: [BoxShadow(offset: Offset(0, 4), blurRadius: 32, color: koyugri)],
                  ),
                  child: Row(
                    children: [
                      Spacer(),
                      GestureDetector(
                        onTap: (){setState(() {blokdata.add([1, "server/kahramanmaraş.jpg",]);});},
                        child: Container(
                          height: 40, width: 50,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                          child: Icon(Icons.camera_alt, size: 38, color: lacivert,),
                        ),
                      ),
                      Spacer(flex: 2,),
                      Container(
                        width: size.width * 0.9 - 90,
                        height: height - 10,
                        padding: EdgeInsets.symmetric(horizontal: margin / 2),
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(20), color: lacivert,),
                        child: TextField(
                          controller: blokcon,
                          maxLines: 40,
                          decoration: InputDecoration(
                            hintText: "Blok Yazın",
                            hintStyle: TextStyle(
                              letterSpacing: 2,
                              color: Colors.black54,
                              fontWeight: FontWeight.bold,
                            ),
                            border: InputBorder.none
                          ),
                          onChanged: (val){
                            setState(() {
                              if(blokcon.text.length <= 40) height = 55;
                              else if(blokcon.text.length <= 85) height = 75;
                              else if(blokcon.text.length <= 138) height = 95;
                              else height = 115;
                            });
                          },
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.none,
                        ),
                      ),
                      Spacer(),
                      GestureDetector(
                        onTap: (){setState(() {blokdata.add([0, blokcon.text,]);});},
                        child: Container(
                          height: 40, width: 45,
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),),
                          child: Icon(Icons.send, size: 38, color: lacivert,),
                        ),
                      ),
                      Spacer()
                    ],
                  ),
                )
              ],
            ),
          ]
        ),
      ),
    );
  }
  Row blokyazi(double bosluk, Size size, String yazi) {
    return Row(
      children: [
        SizedBox(width: bosluk,),
        SizedBox(
            width: size.width * 0.8,
            child: Text(yazi, style: TextStyle(fontSize: 20, color: gir),)
        ),
      ],
    );
  }
  Container blokresim(Size size, double margin, String resim) {
    return Container(
      height: size.height * 0.28, width: size.width * 0.95,
      padding: EdgeInsets.all(margin,),
      child: Image.asset(resim, fit: BoxFit.cover,),
    );
  }
}
class MyCustomClipper extends CustomClipper<Path> {
  double h = 60;
  double w = 50;

  double radius = 40;

  @override
  Path getClip(Size size,) {
    final path = Path();
    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, size.height - h);
    path.lineTo(size.width * 0.3 + radius + w, size.height - h);
    path.quadraticBezierTo(size.width * 0.3 + radius * 0.2 + w, size.height - (h + radius * 0.2),
        size.width * 0.3 + w, size.height - (radius + h));
    path.lineTo(size.width * 0.3, 0);
    return path;
  }

  @override
  bool shouldReclip(MyCustomClipper oldClipper) => false;

}