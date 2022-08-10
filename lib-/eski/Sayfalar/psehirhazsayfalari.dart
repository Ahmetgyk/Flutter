import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/Sayfalar/planserver.dart';
import 'package:flutter_app/sqlfite/EventDatabase.dart';
import 'package:flutter_app/sqlfite/PlanDatabase.dart';
import 'package:intl/intl.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/server.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/init/local_keys.g.dart';
import 'package:flutter_app/init/string_ext.dart';

class Besincisayfa extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(width: size.width / 2, height: size.height / 2, color: Colors.yellow,);
  }
}

class Dorduncusayfa extends StatelessWidget {
  List<int> cevaplar;
  TextEditingController isimcon;
  DateTime bastime;
  DateTime bittime;
  int bas;
  int bit;
  Dorduncusayfa(this.cevaplar, this.bas, this.bit, this.isimcon, this.bastime, this.bittime);

  Color siyah = Color(0xffb202020);
  Color aciksiyah = Color(0xffb333533);
  Color gri = Color(0xffbD6D6D6);
  Color aciksari = Color(0xffbFFEE32);
  Color sari = Color(0xffbFFD100);
  Color kirmizi = Color(0xffbDB3A34);
  Color yesil = Color(0xffb709C09);

  final planHelper = PlanDatabase.instance;
  final eventHelper = EventDatabase.instance;

  List<String> evethayir = [];
  List<Widget> soruWidget = [];

  List<String> Sehirler = ['İstanbul', 'Ankara', 'İzmir', 'Bursa', 'Antalya', 'Edirme', 'Muğla', 'Çanakkale', 'Trabzon', 'Kahramanmaraş'];

  PlanOlusturma() async {
    DateTime date = DateTime.now();
    Map<String, dynamic> planrow = {
      planHelper.columnName: isimcon.text,
      planHelper.columnPlanlar : DateTime(date.year, date.month, date.day, date.hour, date.minute).toIso8601String(),
      planHelper.columnBaslangicSehir : Sehirler[bas],
      planHelper.columnBaslangicTarih : bastime.toIso8601String(),
      planHelper.columnBitisSehir : Sehirler[bit],
      planHelper.columnBitisTarih : bittime.toIso8601String()
    };
    planHelper.insert(planrow);

    List<Map<String, dynamic>> events = [];
    for(int i = 0; i < planmap.length; i ++){
      Map<String, dynamic> haraketrow = {
        eventHelper.columnYer : planmap[i]["yer"],
        eventHelper.columnHaraket : planmap[i]["haraket"],
        eventHelper.columnIcon : planmap[i]["icon"],
        eventHelper.columnBaslandic : planmap[i]["baslangic"],
        eventHelper.columnBiris : planmap[i]["bitis"]
      };
      eventHelper.insert(haraketrow, DateTime(date.year, date.month, date.day, date.hour, date.minute).toIso8601String());
      events.add(await eventHelper.getItem(i + 1, DateTime(date.year, date.month, date.day, date.hour, date.minute).toIso8601String()));
    }
    print('plan : ${planrow}');
    print('liste : ${events}');
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Widget CevapList(){
      for(int i = 0; i < cevaplar.length; i ++){
        if(cevaplar[i] == 2) evethayir.add(localKeys.planhazirlamasayfasi_evet.locale);
        if(cevaplar[i] == 1) evethayir.add(localKeys.planhazirlamasayfasi_belki.locale);
        if(cevaplar[i] == 0) evethayir.add(localKeys.planhazirlamasayfasi_hayir.locale);
        soruWidget.add( Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
            width: size.width * 0.7,
            child: Row(
              children: [
                SizedBox(width: 10,),
                SizedBox(width: size.width * 0.45, child: Center(child: Text(Plansorulari[i], style: TextStyle(fontSize: 25),),),),
                SizedBox(width: 70, child: Text(evethayir[i], style: TextStyle(fontSize: 19, fontWeight: FontWeight.w800)),)
              ],
            ),
          ),
        ));
      }
      return Column(children: soruWidget,);
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: size.width * 0.8, height: size.height * 0.6,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: gri
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Text('${localKeys.planhazirlamasayfasi_planadi.locale} : ${isimcon.text}',
                  style: TextStyle(fontSize: 20, color: aciksiyah),),
                SizedBox(height: 10,),
                Text('${localKeys.planhazirlamasayfasi_baslanacaksehir.locale} : ${Sehirler[bas]}',
                  style: TextStyle(fontSize: 20, color: yesil),),
                SizedBox(height: 10,),
                Text('${localKeys.planhazirlamasayfasi_bitirileceksehir.locale}: ${Sehirler[bit]}',
                  style: TextStyle(fontSize: 20, color: kirmizi),),
                SizedBox(height: 10,),
                Text('${localKeys.planhazirlamasayfasi_baslangictarihi.locale} : ${DateFormat.yMMMd().format(bastime)}',
                  style: TextStyle(fontSize: 20, color: yesil),),
                SizedBox(height: 10,),
                Text('${localKeys.planhazirlamasayfasi_bitistarihi.locale} : ${DateFormat.yMMMd().format(bittime)}',
                  style: TextStyle(fontSize: 20, color: kirmizi),),
                SizedBox(height: 10,),
                Container(child: CevapList())
              ],
            ),
          ),
        ),
        GestureDetector(
          child: Container(
            width: size.width * 0.8, height: size.height * 0.1,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: siyah
            ),
            child: Center(
              child: Text(localKeys.planhazirlamasayfasi_gonder.locale, style: TextStyle(fontSize: 30, color: gri),),
            ),
          ),
          onTap: PlanOlusturma,
        ),
      ],
    );
  }
}

class Ucuncusayfa extends StatefulWidget {
  List<int> cevaplar;
  Ucuncusayfa(this.cevaplar);

  @override
  _UcuncusayfaState createState() => _UcuncusayfaState(cevaplar);
}
class _UcuncusayfaState extends State<Ucuncusayfa> {
  List<int> cevaplar;
  _UcuncusayfaState(this.cevaplar);

  Color siyah = Color(0xff202020);
  Color aciksiyah = Color(0xff333533);
  Color gri = Color(0xffD6D6D6);
  Color aciksari = Color(0xffFFEE32);
  Color sari = Color(0xffFFD100);
  Color kirmizi = Color(0xffbB3A34);
  Color yesil = Color(0xff709C09);

  List<Widget> sorular = [];
  Widget Sorular(){
    for(int i = 0; i < 7; i++) sorular.add(SoruCard(i));
    return Column(children: sorular);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width * 0.8, height: size.height * 0.7,
      child: SingleChildScrollView(
          child: Sorular()
      ),
    );
  }

  Column SoruCard(int i) {
    return Column(
      children: [
        Container(
          height: 50, width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: aciksiyah),
          child: Center(child: Text('${Plansorulari[i]}', style: TextStyle(fontSize: 20, color: gri), textAlign: TextAlign.center,)),
        ),
        Row(
          children: [
            GestureDetector(
              child: Container(
                  height: 40, width: MediaQuery.of(context).size.width * 0.8 / 3,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)), color: yesil),
                  child: Center(child: Text(localKeys.planhazirlamasayfasi_evet.locale, style: TextStyle(fontSize: 30)))),
              onTap: (){cevaplar[i] = 2; print(cevaplar);},
            ),
            GestureDetector(
              child: Container(
                  height: 40, width: MediaQuery.of(context).size.width * 0.8 / 3, color: sari,
                  child: Center(child: Text(localKeys.planhazirlamasayfasi_belki.locale, style: TextStyle(fontSize: 30)))),
              onTap: (){cevaplar[i] = 1; print(cevaplar);},
            ),
            GestureDetector(
              child: Container(
                  height: 40, width: MediaQuery.of(context).size.width * 0.8 / 3,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)), color: kirmizi),
                  child: Center(child: Text(localKeys.planhazirlamasayfasi_hayir.locale, style: TextStyle(fontSize: 30)))),
              onTap: (){cevaplar[i] = 0; print(cevaplar);},
            ),
          ],
        ),
        SizedBox(height: 10,),
      ],
    );
  }
}