import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/init/local_keys.g.dart';
import 'package:flutter_app/init/string_ext.dart';
import 'package:flutter_app/init/theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/utils.dart';
import 'SingupPage.dart';
import 'LoginPage.dart';

class TemelGiris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: temelGiris(),
    );
  }
}


class temelGiris extends StatefulWidget {
  @override
  _TemelGirisState createState() => _TemelGirisState();
}
class _TemelGirisState extends State<temelGiris> {

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    List<Widget> sayfaicon = [];
    for(int i = 0; i < 3; i++){
      if(i == _page) sayfaicon.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: Container(width: 30, height: 13,
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(6) ,color: Color(0xffD6D6D6)),
        )
      ));
      else sayfaicon.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: Icon(Icons.brightness_1_outlined, size: 15, color: Color(0xffD6D6D6),),
      ));
    }

    return Scaffold(
      body: Column(
        children: [
          Expanded(flex: 5, child: UstWidget(w, h, sayfaicon),),
          Expanded(flex: 2, child: AltWidget(h, w, context),)
        ],
      )
    );
  }

  Container AltWidget(double h, double w, BuildContext context) {
    return Container(
          color: Color(0xff30475E),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Spacer(flex: 2,),
                GestureDetector(
                  child: Container(
                      height: h * 0.07,
                      width: w * 0.8,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xffbC6DE41)) ,
                      child: Center(
                        child: Text(localKeys.SingupLogin_giris.locale, style: TextStyle(fontSize: 30, color: Color(0xffb333533), fontWeight: FontWeight.w600)),
                      )
                  ),
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => LogInPage()));},
                ),
                Spacer(flex: 1,),
                GestureDetector(
                  child: Container(
                      height: h * 0.07,
                      width: w * 0.8,
                      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xffFCA311)) ,
                      child: Center(
                        child: Text(localKeys.SingupLogin_kayit.locale, style: TextStyle(fontSize: 30, color: Color(0xffb333533), fontWeight: FontWeight.w600)),
                      )
                  ),
                  onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SingUpPage()));},
                ),
                Spacer(flex: 2,),
              ],
            )
          ),
        );
  }
  Container UstWidget(double w, double h, List<Widget> sayfaicon) {
    return Container(
          color: Color(0xff222831),
          child: Stack(
            children: [
              Container(
                width: w, height: h * 5/7,
                child: PageView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    IconWidget(w: w, h: h * 5/7,
                      widget: Container(height: w * 0.5, width: w * 0.5,
                        child: Image.asset('assets/icons/questionnaire.png', fit: BoxFit.cover,),),
                      yazi: 'Soruları cevapla',),
                    IconWidget(w: w, h: h * 5/7,
                      widget: Container(height: w * 0.5, width: w * 0.5,
                        child: Image.asset('assets/icons/navigator.png', fit: BoxFit.cover,),),
                      yazi: 'Planını oluştur',),
                    IconWidget(w: w, h: h * 5/7,
                      widget: CircleAvatar(radius: 100, backgroundColor: Color(0xffcea105),
                        child: Image.asset('assets/icons/passport.png', fit: BoxFit.cover,)),
                      yazi: 'Tatilin keyfini çıkart'),
                  ],
                  onPageChanged: (value) {setState(() {_page = value;});},
                ),
              ),
              Positioned(
                bottom: 10, child: Container(
                  width: w,
                  child: Center(
                    child: Row(mainAxisAlignment: MainAxisAlignment.center, children: sayfaicon,)
                  ),
                ),
              )
            ],
          ),
        );
  }
}
class IconWidget extends StatelessWidget {
  Widget widget;
  String yazi;
  double w;
  double h;

  IconWidget({this.widget, this.yazi, this.w, this.h});
  @override
  Widget build(BuildContext context) {
    return Container(width: w, height: h * 5/7,
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget,
          SizedBox(height: 10,),
          Text(yazi, style: TextStyle(fontSize: 40, color: Color(0xffD6D6D6)),)
        ],
      ),),
    );
  }
}

