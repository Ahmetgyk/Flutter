import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';


class planPage extends StatefulWidget {
  @override
  _State createState() => _State();
}
class _State extends State<planPage> {
  final genelcon = GlobalKey<FormState>();

  List<String> sorular = [
    "Resim sergisine gitmeyi sever misiniz ?",
    "Tiyatro ile ilgili misiniz ?",
    "Müzeye ilgi duyar mısınız ?",
    "Şehir içi yerler mi, deniz kıyısı yerler mi tercih edersiniz ?",
    "Spor ile aranız nasıl ?",
    "Tarih ile ilgilenir misiniz ?",
    "İbadethanelere ilgi duyar mısınız ?",
    "Doğal yapılar mı yoksa tarihi yapılarmı daha çok ilginizi çekiyor ?",
    "Ziyaret edeceğiniz mekanlar kalabalık olsa sizin için problem yaratır mı ?",
    "Kalabalık mekanlar mı tercih edersiniz yoksa daha tenha yerler mi tercih edersiniz ?",
    "Teknolojiye ilgilniz var mı ?",
    "Peki ya edebiyata ilginiz var mı ?"
  ];

  List<String> Sehirler = ['İstanbul', 'Ankara', 'İzmir', 'Antalya', 'Konya', 'Kayseri'];
  int bit = 2;
  int bas = 3;

  void BasSehir(){
    if(genelcon.currentState.validate()){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context){
            return AlertDialog(
              backgroundColor: Color(0xffbC0C0C0),
              title: Text("baslanacaksehir",
                  style: TextStyle(fontSize: 20, color: Colors.black,)),
              content: SizedBox(
                  width: 180, height: 300,
                  child: CupertinoPicker(
                    itemExtent: 64,
                    children: Sehirler.map((e) => Center(child: Text(e, style: TextStyle(fontSize: 32),),)).toList(),
                    onSelectedItemChanged: (i){bas = i;},
                  )
              ),
              actions: [FlatButton(onPressed:() {setState(() {Navigator.pop(context);});}, child: Text('Tamam'))],
            );
          }
      );
    }
  }
  void BitSehir(){
    if(genelcon.currentState.validate()){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context){
            return AlertDialog(
              backgroundColor: Color(0xffbC0C0C0),
              title: Text('baslanacaksehir',
                  style: TextStyle(fontSize: 20, color: Colors.black,)),
              content: SizedBox(
                  width: 180, height: 300,
                  child: CupertinoPicker(
                    itemExtent: 64,
                    children: Sehirler.map((e) => Center(child: Text(e, style: TextStyle(fontSize: 32),),)).toList(),
                    onSelectedItemChanged: (i){bit = i;},
                  )
              ),
              actions: [FlatButton(onPressed:() {setState(() {Navigator.pop(context);});}, child: Text('Tamam'))],
            );
          }
      );
    }
  }

  Color siya = Color(0xff222831);
  Color aciksiyah = Color(0xff333533);
  Color gri = Color(0xffD6D6D6);
  Color aciksari = Color(0xffFFEE32);
  Color sari = Color(0xffFFD100);
  Color kirmizi = Color(0xffbB3A34);
  Color yesil = Color(0xff709C09);

  List<int> cevaplar = [];
  Column SoruCard(int i) {
    return Column(
      children: [
        Container(
          height: 50, width: MediaQuery.of(context).size.width * 0.8,
          decoration: BoxDecoration(borderRadius: BorderRadius.vertical(top: Radius.circular(20)), color: aciksiyah),
          child: Center(child: Text('${sorular[i]}', style: TextStyle(fontSize: 20, color: gri), textAlign: TextAlign.center,)),
        ),
        Row(
          children: [
            GestureDetector(
              child: Container(
                  height: 40, width: MediaQuery.of(context).size.width * 0.8 / 3,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20)), color: yesil),
                  child: Center(child: Text("evet", style: TextStyle(fontSize: 30)))),
              onTap: (){cevaplar[i] = 2; print(cevaplar);},
            ),
            GestureDetector(
              child: Container(
                  height: 40, width: MediaQuery.of(context).size.width * 0.8 / 3, color: sari,
                  child: Center(child: Text("belki", style: TextStyle(fontSize: 30)))),
              onTap: (){cevaplar[i] = 1; print(cevaplar);},
            ),
            GestureDetector(
              child: Container(
                  height: 40, width: MediaQuery.of(context).size.width * 0.8 / 3,
                  decoration: BoxDecoration(borderRadius: BorderRadius.only(bottomRight: Radius.circular(20)), color: kirmizi),
                  child: Center(child: Text("hayir", style: TextStyle(fontSize: 30)))),
              onTap: (){cevaplar[i] = 0; print(cevaplar);},
            ),
          ],
        ),
        SizedBox(height: 10,),
      ],
    );
  }
  List<Widget> sorucards = [];
  Widget Sorular(){
    sorucards.clear();
    for(int i = 0; i < sorular.length; i++){
      cevaplar.add(null);
      sorucards.add(SoruCard(i));
    }
    return Column(children: sorucards);
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Form(
      key: genelcon,
      child: Container(
        color: siya,
        height: MediaQuery.of(context).size.height - 80,
        child: Stack(
          children: [
            SingleChildScrollView(
              child: Container(
                height: 1600,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    GestureDetector(
                      child: BaslanacakSehir(size),
                      //onTap: BasSehir,
                    ),
                    GestureDetector(
                      child: BitirilecekSehir(size),
                      //onTap: BitSehir,
                    ),
                    Sorular(),
                    GestureDetector(
                        child: LoginContainer(size.height, size.width),
                        onTap: (){}
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  Container LoginContainer(double h, double w) {
    return Container(
        height: h * 0.07,
        width: w * 0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xffbC6DE41)) ,
        child: Center(
          child: Text('PlanOlustur', style: TextStyle(fontSize: 30, color: Color(0xffb333533))),
        ));
  }

  Container BaslanacakSehir(Size size) {
    return Container(
      width: size.width *0.8, height: size.height * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)), color: gri.withOpacity(0.5),
          border: Border.all(width: 3, color: Colors.grey)
      ),
      child: Center(
        child: Text(bas == null ? "baslanacaksehir" : Sehirler[bas]
            , style: TextStyle(fontSize: 30,)),
      ),
    );
  }
  Container BitirilecekSehir(Size size) {
    return Container(
      width: size.width *0.8, height: size.height * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)), color: gri.withOpacity(0.5),
          border: Border.all(width: 3, color: Colors.grey)
      ),
      child: Center(
        child: Text(bit == null ? "bitirileceksehir" : Sehirler[bit]
            , style: TextStyle(fontSize: 30,)),
      ),
    );
  }
}