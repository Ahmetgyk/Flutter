import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:gtourkey/Server/server.dart';

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

Color buton = Color(0xffF3A953);
Color arkafon = Color(0xffD6D6D6);
Color yazi = Color(0xffDDDDDD);
Color anaYazi = Color(0xff323643);
Color ikincifon = Color(0xff276678);

class anaSayfa extends StatefulWidget {
  @override
  _anaSayfaState createState() => _anaSayfaState();
}

class _anaSayfaState extends State<anaSayfa> with SingleTickerProviderStateMixin {

  List<List<String>> sellectevent = [];

  bool isanim = false;
  late AnimationController _controller;
  late Animation<double> _dbanim;
  late Animation<double> _curve;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 700), vsync: this);

    _curve = CurvedAnimation(parent: _controller, curve: Curves.easeOutSine);

    _dbanim = TweenSequence(
        <TweenSequenceItem<double>>[
          TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: 10), weight: 10),
        ]
    ).animate(_curve);

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) setState(() {isanim = true;});
      if(status == AnimationStatus.dismissed) setState(() {isanim = false;});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    double bosluk = 20;
    double margin = 10;
    double radius = 25;

    Map<String, List<List<String>>> eventMap = {
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 2).toIso8601String() :
      [["mekan1.1", "açıklama1.1", "icon1.1", "bitiş1.1",], ["mekan1.2", "açıklama1.2", "icon1.2", "bitiş1.2",], ["mekan1.3", "açıklama1.3", "icon1.3", "bitiş1.3",], ["mekan1.4", "açıklama1.4", "icon1.4", "bitiş1.4",],
        ["mekan1.1", "açıklama1.1", "icon1.1", "bitiş1.1",], ["mekan1.2", "açıklama1.2", "icon1.2", "bitiş1.2",], ["mekan1.3", "açıklama1.3", "icon1.3", "bitiş1.3",], ["mekan1.4", "açıklama1.4", "icon1.4", "bitiş1.4",],],
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 3).toIso8601String() :
      [["mekan2.1", "açıklama2.1", "icon2.1", "bitiş2.1",], ["mekan2.2", "açıklama2.2", "icon2.2", "bitiş2.2",], ["mekan2.3", "açıklama2.3", "icon2.3", "bitiş2.3",], ["mekan2.4", "açıklama2.4", "icon2.4", "bitiş2.4",],],
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day).toIso8601String() :
      [["mekan3.1", "açıklama3.1", "icon3.1", "bitiş3.1",], ["mekan3.2", "açıklama3.2", "icon3.2", "bitiş3.2",],],
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 1).toIso8601String() :
      [["mekan4.1", "açıklama4.1", "icon4.1", "bitiş4.1",], ["mekan4.2", "açıklama4.2", "icon4.2", "bitiş4.2",], ["mekan4.3", "açıklama4.3", "icon4.3", "bitiş4.3",], ["mekan4.4", "açıklama4.4", "icon4.4", "bitiş4.4",],],
      DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day + 2).toIso8601String() :
      [["mekan5.1", "açıklama5.1", "icon5.1", "bitiş5.1",], ["mekan5.2", "açıklama5.2", "icon5.2", "bitiş5.2",], ["mekan5.3", "açıklama5.3", "icon5.3", "bitiş5.3",],],
    };
    List<DateTime> eventdate = [];
    eventMap.forEach((key, value) {eventdate.add(DateTime.parse(key));});

    List<Widget> eventwidget = [];
    if(sellectevent.isNotEmpty)
      for(int i = 0; i < sellectevent.length; i++)
        eventwidget.add(hareketCell(size, margin, radius, bosluk, "12:45", sellectevent[i][3], sellectevent[i][0], sellectevent[i][1]));

    List<Widget> favoriler = [];
    for(int i = 0; i < 2; i++)
      for(int i = 0; i < TrendSehir.length; i++)
        for(int e = 0; e < Sehirler.length; e++)
          if(Sehirler[e]?["isim"] == TrendSehir[i])
            favoriler.add(RCard(size, radius, Sehirler[e]?["resim"], Sehirler[e]?["isim"],
                Sehirler[e]?["tür"], Sehirler[e]?["kalp"], Sehirler[e]?["ziyaret"]));

    return Scaffold(
      backgroundColor: arkafon,
      //body: Yukleme(size, margin, bosluk, radius,),
      body: Yuklendi(size, margin, bosluk, radius, eventdate, eventMap, eventwidget, favoriler),
    );
  }

  SingleChildScrollView Yukleme(Size size, double margin, double bosluk, double radius,) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: bosluk,),
            Container(
              height: size.height * 0.05, width: size.width * 0.7,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: aciksiya,
              ),
            ),
            SizedBox(height: bosluk,),
            Container(
              height: size.height * 0.05, width: size.width * 0.4,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(radius),
                color: aciksiya,
              ),
            ),
            SizedBox(height: bosluk / 3,),
            yoTakvim(size, radius),
            SizedBox(height: bosluk,),
            yoBildirim(size, margin, radius, bosluk),
            SizedBox(height: bosluk,),
            yoFavoriler(size, margin, radius, bosluk),
            SizedBox(height: bosluk,),
            yoOneriler(size, margin, radius, bosluk),
            SizedBox(height: bosluk,),
          ],
        ),
      ),
    );
  }
  Container yoOneriler(Size size, double margin, double radius, double bosluk) {
    return Container(
      width: size.width * 0.95,
      padding: EdgeInsets.only(left: margin, right: margin,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: aciksiya, width: 4),
        color: ikincifon,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: bosluk,),
              Container(
                height: size.height * 0.05, width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: aciksiya,
                ),
              ),
            ],
          ),
          SizedBox(height: bosluk / 6,),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [YCard(size, radius), YCard(size, radius),],)
          ),
          SizedBox(height: bosluk,),
        ],
      ),
    );
  }
  Container yoFavoriler(Size size, double margin, double radius, double bosluk) {
    return Container(
      width: size.width * 0.95,
      padding: EdgeInsets.only(left: margin, right: margin,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: aciksiya, width: 4),
        color: ikincifon,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: bosluk,),
              Container(
                height: size.height * 0.05, width: size.width * 0.4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: aciksiya,
                ),
              ),
            ],
          ),
          SizedBox(height: bosluk / 6,),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(children: [YCard(size, radius), YCard(size, radius),],)
          ),
          SizedBox(height: bosluk,),
        ],
      ),
    );
  }
  Container yoBildirim(Size size, double margin, double radius, double bosluk) {
    return Container(
      width: size.width * 0.95,
      padding: EdgeInsets.all(margin / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: aciksiya, width: 4),
          color: ikincifon
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: size.height * 0.05, width: size.width * 0.7,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: aciksiya,
            ),
          ),
          SizedBox(height: bosluk / 3,),
          Container(
            height: size.height * 0.05, width: size.width * 0.4,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              color: aciksiya,
            ),
          ),
          SizedBox(height: bosluk / 3,),
          Row(
            children: [
              SizedBox(width: bosluk / 4,),
              Container(
                height: size.height * 0.05, width: size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: aciksiya,
                ),
              ),
              SizedBox(width: bosluk / 2,),
              Container(
                height: size.height * 0.05, width: size.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: aciksiya,
                ),
              ),
            ],
          ),
          SizedBox(height: bosluk / 3,),
          Stack(
            children: [
              Container(
                height: size.height * 0.2, width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: aciksiya,
                ),
              ),
              Positioned(
                bottom: 10, right: 10,
                child: Container(
                  height: size.height * 0.04, width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      color: ikincifon
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  Stack yoTakvim(Size size, double radius,) {
    return Stack(
      children: [
        Container(
          height: size.height * 0.16, width: size.width * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: aciksiya, width: 4),
              color: ikincifon
          ),
        ),
        Container(
          height: size.height * 0.13, width: size.width * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: aciksiya, width: 4),
              color: ikincifon
          ),
          child: Row(
            children: [
              Container(
                height: size.height * 0.13, width: size.width * 0.35,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: aciksiya
                ),
              ),
              Stack(
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: Divider(color: aciksiya, height: 50, thickness: 4, indent: 8, endIndent: 8,),
                    ),
                    Positioned(
                      top: size.height * 0.02, left: size.width * 0.015,
                      child: CircleAvatar(
                        radius: 18,
                        backgroundColor: aciksiya,
                      ),
                    )
                  ]
              ),
              Container(
                height: size.height * 0.13, width: size.width * 0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: aciksiya
                ),
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: Container(
              height: size.height * 0.07, width: size.width * 0.95,
              child: Icon(Icons.horizontal_rule_sharp, size: 80, color: gr,)
          ),
        )
      ],
    );
  }

  Stack YCard(Size size, double radius,) {
    return Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: size.height * 0.2, width: size.width * 0.8,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: aciksiya,
              borderRadius: BorderRadius.circular(radius),
            ),
          ),
          Positioned(
            bottom: 0, right: 5,
            child: Container(
              height: size.height * 0.175, width: size.width * 0.35,
              margin: EdgeInsets.all(size.width * 0.04),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.vertical(bottom: Radius.circular(radius)),
                  color: siya
              ),
            ),
          ),
        ]
    );
  }

  SingleChildScrollView Yuklendi(Size size, double margin, double bosluk, double radius, List<DateTime> eventdate, Map<String, List<List<String>>> eventMap, List<Widget> eventwidget, List<Widget> favoriler) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Container(
        width: size.width,
        margin: EdgeInsets.symmetric(horizontal: margin),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 60,),
            Text("Merhaba Mahmut,", style: TextStyle(color: anaYazi, fontSize: 30, fontWeight: FontWeight.w600,)),
            SizedBox(height: bosluk,),
            Text(isanim?"Plan takvimi;":"Anlık plan;", style: TextStyle(color: anaYazi.withOpacity(0.7), fontSize: 20, fontWeight: FontWeight.w600,)),
            SizedBox(height: bosluk / 3,),
            ysTakvim(size, radius, eventdate, eventMap, eventwidget),
            SizedBox(height: bosluk,),
            ysBildirim(size, margin, radius, bosluk),
            SizedBox(height: bosluk,),
            ysFavoriler(size, margin, radius, bosluk, favoriler),
            SizedBox(height: bosluk,),
            ysOneriler(size, margin, radius, bosluk, favoriler),
            SizedBox(height: bosluk,),
          ],
        ),
      ),
    );
  }
  Container ysOneriler(Size size, double margin, double radius, double bosluk, List<Widget> favoriler) {
    return Container(
      width: size.width * 0.95,
      padding: EdgeInsets.only(left: margin, right: margin,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: aciksiya, width: 4),
        color: ikincifon,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: bosluk,),
              SizedBox(
                width: size.width * 0.7,
                child:Text("İlginizi çekebilir", style: TextStyle(fontSize: 25, color: yesi),),
              )
            ],
          ),
          SizedBox(height: bosluk / 6,),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: favoriler,
              )
          ),
          SizedBox(height: bosluk,),
        ],
      ),
    );
  }
  Container ysFavoriler(Size size, double margin, double radius, double bosluk, List<Widget> favoriler) {
    return Container(
      width: size.width * 0.95,
      padding: EdgeInsets.only(left: margin, right: margin,),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        border: Border.all(color: aciksiya, width: 4),
        color: ikincifon,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              SizedBox(width: bosluk,),
              SizedBox(
                width: size.width * 0.7,
                child:Text("Favorilriniz", style: TextStyle(fontSize: 20, color: yesi),),
              )
            ],
          ),
          SizedBox(height: bosluk / 6,),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: favoriler,
              )
          ),
          SizedBox(height: bosluk,),
        ],
      ),
    );
  }
  Container ysBildirim(Size size, double margin, double radius, double bosluk) {
    return Container(
      width: size.width * 0.95,
      padding: EdgeInsets.all(margin / 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius),
          border: Border.all(color: aciksiya, width: 4),
          color: ikincifon
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25,
                backgroundColor: Colors.transparent,
                child: Icon(Icons.account_circle_outlined, size: 50, color: aciksiya,),
              ),
              SizedBox(width: 20,),
              Text("Mahmut Yıldırım,", style: TextStyle(fontSize: 26, fontWeight: FontWeight.w600, color: gr),)
            ],
          ),
          SizedBox(height: bosluk / 3,),
          Row(
            children: [
              SizedBox(width: bosluk / 4,),
              Text("Tatilde güneşten kaçınmayı unutma", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: gr),),
            ],
          ),
          SizedBox(height: bosluk / 3,),
          Row(
            children: [
              SizedBox(width: bosluk / 4,),
              Text("% 75", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600, color: gr),),
              SizedBox(width: bosluk / 2,),
              TweenAnimationBuilder(
                tween: Tween<double>(begin: 0, end: 0.75),
                duration: Duration(milliseconds: 500),
                builder: (BuildContext context, double val, Widget? child){
                  return Container(
                    height: 20, width: size.width * 0.7,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(radius),
                        gradient: LinearGradient(
                          colors: [yesi, gr],
                          begin: Alignment.bottomLeft,
                          end: Alignment.bottomRight,
                          stops: [val - 0.01, val + 0.01],
                        )
                    ),
                  );
                },
              ),
            ],
          ),
          SizedBox(height: bosluk / 3,),
          Stack(
            children: [
              Container(
                height: size.height * 0.2, width: size.width * 0.9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  image: DecorationImage(image: AssetImage("lib/Server/ayasofya.jpg"), fit: BoxFit.cover),
                ),
              ),
              Positioned(
                bottom: 10, right: 10,
                child: Container(
                  height: size.height * 0.04, width: size.width * 0.4,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      color: ikincifon
                  ),
                  child: Center(child: Text("03/05/2021", style: TextStyle(color: gir, fontSize: 20),),),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
  Stack ysTakvim(Size size, double radius, List<DateTime> eventdate, Map<String, List<List<String>>> eventMap, List<Widget> eventwidget) {
    return Stack(
      children: [
        AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, _){
              return Container(
                  height: size.height * (0.16 + _dbanim.value * 0.055), width: size.width * 0.95,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      border: Border.all(color: aciksiya, width: 4),
                      color: ikincifon
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        SizedBox(height: size.height * 0.13),
                        _dbanim.value >= 2? Container(
                            height: size.height * 0.13, width: size.width * 0.95,
                            child: DatePicker(
                              DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 2),
                              initialSelectedDate: DateTime.now(),
                              activeDates: eventdate,
                              onDateChange: (date){
                                eventMap.forEach((key, value) {
                                  if(DateTime.parse(key) == date)
                                    setState(() {
                                      sellectevent = value;
                                    });
                                });
                              },
                            )
                        ) : Container(),
                        _dbanim.value >= 2? Divider(color: aciksiya, height: 10, thickness: 2, indent: 15, endIndent: 15,) : Container(),
                        _dbanim.value ==10 ? SingleChildScrollView(
                            child: Column(children: eventwidget.length == 0 ? [Text("Bu günlik aktiviteniz yok")] : eventwidget,)) : Container(),
                      ],
                    ),
                  )
              );
            }
        ),
        Container(
          height: size.height * 0.13, width: size.width * 0.95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(radius),
              border: Border.all(color: aciksiya, width: 4),
              color: ikincifon
          ),
          child: Row(
            children: [
              Container(
                height: size.height * 0.13, width: size.width * 0.35,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  image: DecorationImage(image: AssetImage("lib/Server/ayasofya.jpg"), fit: BoxFit.fitHeight),
                ),
              ),
              Stack(
                  children: [
                    RotatedBox(
                      quarterTurns: 1,
                      child: Divider(color: aciksiya, height: 50, thickness: 4, indent: 8, endIndent: 8,),
                    ),
                    Positioned(
                      top: size.height * 0.02, left: size.width * 0.015,
                      child: CircleAvatar(
                          radius: 18,
                          backgroundColor: aciksiya,
                          child: Icon(Icons.account_balance_sharp, size: 20, color: ikincifon,)
                      ),
                    )
                  ]
              ),
              SizedBox(height: size.height * 0.1, width: size.width * 0.45,
                  child:  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 10,),
                      Text("12.30 - 15.45", style: TextStyle(color: gr, fontSize: 15),),
                      Text("Ayasofya Cami Gezilecek", style: TextStyle(color: gr, fontSize: 20),),
                    ],
                  )
              ),
            ],
          ),
        ),
        Positioned(
          bottom: 0,
          child: GestureDetector(
            onTap: (){setState(() {isanim? _controller.reverse() : _controller.forward();});},
            child: Container(
                height: size.height * 0.07, width: size.width * 0.95,
                child: Icon(Icons.horizontal_rule_sharp, size: 80, color: gr,)
            ),
          ),
        )
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
  Container hareketCell(Size size, double margin, double radius, double bosluk, String baslangic, String bitis,
      String mekan, String aciklama,) {
    return Container(
        width: size.width * 0.95, height: 90,
        margin: EdgeInsets.symmetric(horizontal: margin,),
        child: Row(
          children: [
            Column(
              children: [
                Spacer(),
                Text(baslangic, style: TextStyle(fontSize: 15, color: gr),),
                Spacer(flex: 3,),
                Text(bitis, style: TextStyle(fontSize: 15, color: gr),),
                Spacer(),
              ],
            ),
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
                        child: Icon(Icons.account_balance_sharp, size: 20, color: ikincifon,)
                    ),
                  )
                ]
            ),
            Container(
              height: size.height * 0.13, width: size.width * 0.61,
              margin: EdgeInsets.all(margin / 2),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(radius),
                  color: gir
              ),
              child: Row(
                children: [
                  Container(
                    height: size.height * 0.13, width: size.width * 0.3,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(radius),
                      image: DecorationImage(image: AssetImage("lib/Server/ayasofya.jpg"), fit: BoxFit.fitHeight),
                    ),
                  ),
                  SizedBox(height: size.height * 0.1, width: size.width * 0.3,
                      child:  Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 10,),
                          Text("Ayasofya Cami Gezilecek", style: TextStyle(color: siya, fontSize: 17),),
                        ],
                      )
                  ),
                ],
              ),
            ),
          ],
        )
    );
  }
}