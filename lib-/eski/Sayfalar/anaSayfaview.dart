import 'package:cron/cron.dart';
import 'package:flutter_app/init/local_keys.g.dart';
import 'package:flutter_app/init/planprovider.dart';
import 'package:flutter_app/init/string_ext.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/server.dart';
import 'package:flutter_app/init/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:scheduled_notifications/scheduled_notifications.dart';
import 'anaSayfaviewmodel.dart';
import 'planserver.dart';
import 'sehirhero.dart';
import 'takvimkopyası.dart';


class AnaSayfaState extends AnaSayfaviewmodel {
  _bildirim() async {
    int notificationId = await ScheduledNotifications.scheduleNotification(
        new DateTime.now().add(new Duration(milliseconds: 5)).millisecondsSinceEpoch,
        "Ticker text",
        "Content title",
        "Content");
  }
  List<dynamic> event = [
    ['Ayasofya ziyareti', '2021-09-02 13:36:30', 'gezi', 'ayasofya'],
    ['KızKulesi ziyareti', '2021-09-02 13:37:00', 'gezi', 'kızkulesi'],
    ['Anıtkabir ziyareti', '2021-09-02 14:38:10', 'gezi', 'anıtkabir'],
    ['galatkulesi ziyareti', '2021-09-02 14:16:01', 'gezi', 'galatakulesi']
  ];
  
  Future<void> main(BuildContext context) async {
    final cron = Cron().schedule(Schedule.parse('*/6 * * * * *'), () {
      Provider.of<PlanData>(context).setPlanData();
      print(Provider.of<PlanData>(context).getgunuplani);
      print("sf");
      print(DateTime.now());
    }
    );
  }
  @override
  void initState() {
    super.initState();
    //events = {};
    //selectevent = [];
    g = DateTime.now().weekday;
    selectevent = events[DateTime(2021, 8, 24)];
    isimcon.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    super.dispose();
    isimcon.dispose();
  }
  @override

  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    //Provider.of<ProfilData>(context).setUserData();
    //Provider.of<PlanData>(context).setPlanData();
    //main(context);

    List<String> ay = [localKeys.takvim_oca.locale, localKeys.takvim_sub.locale, localKeys.takvim_mar.locale,
      localKeys.takvim_nis.locale, localKeys.takvim_may.locale, localKeys.takvim_haz.locale, localKeys.takvim_tem.locale,
      localKeys.takvim_agu.locale, localKeys.takvim_eyl.locale, localKeys.takvim_eki.locale, localKeys.takvim_kas.locale,
      localKeys.takvim_ara.locale];

    Widget guncard(int i, String gun){
      if(i == g){
        return Container(
          height: 100, width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(30)),
              color: theme().renk(theme().Siyah, dark)
          ),
          child: Center(
            child: RotatedBox(quarterTurns: -1,
                child: Text(gun,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme().renk(theme().Gri, dark)),
                )
            ),
          ),
        );
      }
      else{
        return Container(
          height: 60, width: 40,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: theme().renk(theme().Siyah, dark)
          ),
          child: Center(
            child: RotatedBox(quarterTurns: -1,
                child: Text(gun,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: theme().renk(theme().Gri, dark)),
                )
            ),
          ),
        );
      }
    }

    List<Widget> eventlist = [];
    for(int i = 0; i < 3; i ++)eventlist.add(Container(
          width: size.width * 0.7, height: 80,
          margin: EdgeInsets.all(5),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: theme().renk(theme().aciksiyah, dark), width: 3)
          ),
          child: Row(
            children: [
              SizedBox(width: 10),
              SizedBox(
                width: size.width * 0.4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: 10,),
                    Text(selectevent[i][1], style: TextStyle(color: theme().renk(theme().Gri, dark), fontSize: 20),),
                    SizedBox(height: 10,),
                    Text(selectevent[i][0], style: TextStyle(color: theme().renk(theme().Gri, dark), fontSize: 20),),
                  ],
                ),
              ),
              Container(
                  margin: EdgeInsets.all(5),
                  width: size.width * 0.2,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: theme().renk(theme().aciksiyah, dark), width: 3),
                    color: theme().renk(theme().Gri, dark),
                  ),
                  child: Center(child: Icon(eveticon[selectevent[i][2]], size: 30, color: theme().renk(theme().aciksiyah, dark),))
              )
            ],
          )
      ),);
    Widget gunlukPlan(){

      return Container(
        height: 490, width: size.width * 0.8,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.horizontal(right: Radius.circular(40),),
          color: theme().renk(theme().Siyah, dark),
          boxShadow: [
            BoxShadow(
                spreadRadius: -10,
                blurRadius: 12,
                offset: Offset(-5, -3),
                color: dark ?  Colors.black : Colors.white
            ), BoxShadow(
                spreadRadius: -4,
                blurRadius: 12,
                offset: Offset(5, 5),
                color: dark ?  Colors.black : Colors.white
            )
          ],
        ),
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          child: Column(
              children: eventlist
          ),
        ),
      );
    }

    List<Widget> Itemcards = [];
    for(int i = 0; i < 5; i++)Itemcards.add(ItemCard(ad: kopyabina[0][0], sehir: kopyabina[0][1], resim: kopyabina[0][2],
      begeni: kopyabina[0][3], ziyaret: kopyabina[0][4], hava: kopyabina[0][5], sicaklik: kopyabina[0][6],
      renk: kopyabina[0][7], renk2: kopyabina[0][8], tarih: kopyabina[0][9], yildiz: kopyabina[0][10],
      mesaj: kopyabina[0][11], mekanlar: kopyabina[0][12], w: size.width, h: size.height,
    ));

    List<String> adlar = ['İzmir Gezisi', 'Ankara Tatili', 'Kars Kış Tatili', 'Antalya Tatili(aile)', 'Antalya Tatili(arkadaş)', 'İstanbul Turu', 'Muş Proje Ödevi'];
    List<Widget> Plancards = [];
    for(int i = 0; i < 7; i++)
      Plancards.add(GestureDetector(child: PlanCard(i, p, size.width, adlar[i], planBas, planBit, planList, dark),
          onTap: (){setState(() {p = i;});}),);
    Plancards.add(Container(height: 100, width: size.width,),);

    var pages = [
      PlanSayfa(size, Plancards),
      SehirSayfa(size, context, Itemcards),
      AnaSayfa(size, ay, gunlukPlan, guncard),
      HomePage()
    ];

    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBarMethod(),
      drawer: DrawerMethod(context),
      body: pages[page],
      bottomNavigationBar: BottomNavigationBarMethod(size, context),
    );
  }
}
class ItemCard extends StatelessWidget {
  @override
  double w;
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
  double h;

  ItemCard({this.ad, this.sehir, this.resim, this.begeni, this.ziyaret, this.hava, this.sicaklik, this.renk, this.renk2, this.tarih, this.yildiz, this.mesaj, this.mekanlar, this.w, this.h});
  Widget build(BuildContext context) {
    return Container(
        height: w * (0.6), width: w,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            GestureDetector(
              onTap: ()=> Navigator.push(context,
                  MaterialPageRoute(builder: (context)=> ItemHero(
                    ad: ad, resim: resim, renk: renk, renk2: renk2, tarih: tarih, yildiz: yildiz, mesaj: mesaj, mekanlar: mekanlar,
                    hava: hava, sicaklik: sicaklik, press: () => Navigator.pop(context), h: h, w: w,))),
              child: Container(
                margin: EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 35),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                    image: DecorationImage(image: AssetImage(resim), fit: BoxFit.cover)
                ),
              ),
            ),
            Positioned(
              bottom: 8, left: w * 0.15,
              child: Container(
                  height: w * 0.15, width: w * 0.7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30), top: Radius.circular(20)), color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(width: w * 0.35,
                        child:  Row(
                          children: [
                            Icon(Icons.local_fire_department, size: 30, color: Colors.red,),
                            Text(begeni.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.red),),
                          ],
                        ),
                      ),
                      SizedBox(width: w * 0.35,
                        child:  Row(
                          children: [
                            Icon(Icons.supervisor_account_outlined, size: 30, color: Colors.green,),
                            Text(ziyaret.toString(), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25, color: Colors.green),),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Positioned(top: 16, left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(ad, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                    Text(sehir, style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  ],
                )
            ),
            Positioned(bottom: 70, right: 25,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text(sicaklik.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(width: 10,),
                    SizedBox(height: 40, width: 40, child: Image.asset(hava, fit: BoxFit.cover,)),
                  ],
                )
            ),
          ],
        )
    );
  }
}