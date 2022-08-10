import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'planözellikleri.dart';
import 'server.dart';

Color siya = Color(0xff222831);
Color koyugri = Color(0xff333333);
Color gr = Color(0xffDDDDDD);
Color aciksiya = Color(0xff333533);
Color kirmiz = Color(0xff990100);
Color yesi = Color(0xffC6DE41);
Color lacivert = Color(0xff30475E);
Color sar = Color(0xffFCA311);

class Plansayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: plansayfa(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class plansayfa extends StatefulWidget {
  @override
  _plansayfaState createState() => _plansayfaState();
}

class _plansayfaState extends State<plansayfa> with TickerProviderStateMixin {

  List<bool> bools = [];
  List<AnimationController> _controllers = [];
  List<Animation<double>> _dbanims = [];
  List<Animation> _curves = [];

  @override
  void initState() {
    super.initState();

    for(int i = 0; i < Planlar.length; i++){
      bools.add(false);

      _controllers.add(AnimationController(duration: Duration(milliseconds: 500), vsync: this));

      _curves.add(CurvedAnimation(parent: _controllers[i], curve: Curves.easeOutSine));

      _dbanims.add(TweenSequence(
          <TweenSequenceItem<double>>[
            TweenSequenceItem<double>(tween: Tween<double>(begin: 0.14, end: 0.36), weight: 0.4),
          ]
      ).animate(_curves[i]));
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double margin = 10;
    double radius = 25;

    List<Widget> PlanWidget = [];
    for(int i = 0; i < Planlar.length; i++) PlanWidget.add(PlanCard(size, margin, radius, i));

    return Scaffold(
      backgroundColor: siya,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 70,),
            Column(children: PlanWidget,)
          ],
        ),
      )
    );
  }
  
  Stack PlanCard(Size size, double margin, double radius, int x) {
    return Stack(
      children: [
        AnimatedBuilder(
          animation: _controllers[x],
          builder: (BuildContext context, _){
            return Container(
              width: size.width - 2 * margin, height: size.height * _dbanims[x].value,
              margin: EdgeInsets.all(margin), padding: EdgeInsets.all(margin),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                border: Border.all(color: aciksiya, width: 3),
                color: lacivert,
              ),
              child: _dbanims[x].value == 0.36 ? Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: size.height * 0.14 - margin,),
                  Text("${Planlar[x]["baslangic"]} - ${Planlar[x]["bitis"]}", style: TextStyle(color: gr, fontSize: 20),),
                  SizedBox(height: 6,),
                  Text("1- ${Planlar[x]["plan"][x][4]}", style: TextStyle(color: gr, fontSize: 20),),
                  Text("2- ${Planlar[x]["plan"][1][4]}", style: TextStyle(color: gr, fontSize: 20),),
                  Icon(Icons.more_vert, color: gr, size: 30,),
                  Text("21- ${Planlar[x]["plan"][Planlar[x]["plan"].length - 2][4]}", style: TextStyle(color: gr, fontSize: 20),),
                  Text("22- ${Planlar[x]["plan"][Planlar[x]["plan"].length - 1][4]}", style: TextStyle(color: gr, fontSize: 20),),
                ],
              ) : Container(),
            );
          }
        ),
        Container(
          width: size.width - 2 * margin, height: size.height * 0.14,
          margin: EdgeInsets.all(margin),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: aciksiya, width: 3),
            color: lacivert,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(width: 10,),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Hero(
                    tag: Planlar[x]["isim"],
                    child: Text(Planlar[x]["isim"], style: TextStyle(color: gr, fontSize: 45, fontWeight: FontWeight.bold),),
                  ),
                  Text(Planlar[x]["baslangic"], style: TextStyle(color: gr, fontSize: 20),),
                ],
              ),
              Spacer(),
              GestureDetector(
                onTap: (){
                  _controllers[x].addStatusListener((status) {
                    if(status == AnimationStatus.completed) setState(() {bools[x] = true;});
                    if(status == AnimationStatus.dismissed) setState(() {bools[x] = false;});
                  });
                  setState(() {bools[x]? _controllers[x].reverse() : _controllers[x].forward();});
                },
                child: Icon(Icons.info_outline, color: yesi, size: 40,)
              ),
              SizedBox(width: 10,),
              GestureDetector(
                onTap: () => Navigator.push(context, MaterialPageRoute(
                    builder: (context)=> plandetay(Planlar[x]["isim"], Planlar[x]["baslangic"], Planlar[x]["bitis"], Planlar[x]["plan"]))),
                child: Icon(Icons.more_vert, color: yesi, size: 40,),
              ),
              SizedBox(width: 5,),
            ],
          ),
        ),
      ],
    );
  }
}