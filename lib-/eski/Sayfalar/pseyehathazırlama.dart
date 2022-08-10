import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/Sayfalar/anaSayfa.dart';
import 'package:flutter_app/init/theme.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/psehirhazsayfalari.dart';
import 'package:flutter_app/utils.dart';
import 'package:intl/intl.dart';
import 'psehiraramasayfasi.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/init/local_keys.g.dart';
import 'package:flutter_app/init/string_ext.dart';

class SeyehatHaz extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: seyehatHaz(),
    );
  }
}


class seyehatHaz extends StatefulWidget {
  @override
  seyehatHazState createState() => seyehatHazState();
}
class seyehatHazState extends State<seyehatHaz> {
  bool dark = true;
  Color gri = Color(0xffbD6D6D6);
  Color aciksiyah = Color(0xffb333533);

  List<String> Sehirler = ['İstanbul', 'Ankara', 'İzmir', 'Antalya', 'Konya', 'Kayseri'];

  List<int> cevaplar = [];
  Sorular(){for(int i = 0; i < 7; i++) cevaplar.add(null);}
  final isimcon = TextEditingController();
  final genelcon = GlobalKey<FormState>();
  DateTime datetime;
  DateTime bastime;
  DateTime bittime;
  int bas;
  int bit;

  void BasTarih(){
    if(genelcon.currentState.validate()){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context){
            return AlertDialog(
              backgroundColor: Color(0xffbC0C0C0),
              title: Text('Doğum tarihi', style: TextStyle(fontSize: 20, color: Colors.black,)),
              content: SizedBox(
                  height: 180,
                  child: CupertinoDatePicker(
                    minimumYear: DateTime.now().year,
                    maximumYear: 2051,
                    initialDateTime: datetime,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (datetime){setState(() {bastime = datetime;});},
                  )
              ),
              actions: [FlatButton(onPressed:() {setState(() {Navigator.pop(context);});}, child: Text('Tamam'))],
            );
          }
      );
    }
  }
  void BitTarih(){
    if(genelcon.currentState.validate()){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context){
            return AlertDialog(
              backgroundColor: Color(0xffbC0C0C0),
              title: Text('Doğum tarihi', style: TextStyle(fontSize: 20, color: Colors.black,)),
              content: SizedBox(
                  height: 180,
                  child: CupertinoDatePicker(
                    minimumYear: DateTime.now().year,
                    maximumYear: 2051,
                    initialDateTime: datetime,
                    mode: CupertinoDatePickerMode.date,
                    onDateTimeChanged: (datetime){setState(() {bittime = datetime;});},
                  )
              ),
              actions: [FlatButton(onPressed:() {setState(() {Navigator.pop(context);});}, child: Text('Tamam'))],
            );
          }
      );
    }
  }
  void BasSehir(){
    if(genelcon.currentState.validate()){
      showDialog(
          context: context,
          barrierDismissible: true,
          builder: (context){
            return AlertDialog(
              backgroundColor: Color(0xffbC0C0C0),
              title: Text(localKeys.planhazirlamasayfasi_baslanacaksehir.locale,
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
              title: Text(localKeys.planhazirlamasayfasi_bitirileceksehir.locale,
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

  @override
  void initState() {
    super.initState();
    Sorular();
  }

  int _page = 0;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    final pages = [
      IlkSayfa(size, context),
      IkinciSayfa(size),
      Ucuncusayfa(cevaplar),
      Dorduncusayfa(cevaplar, bas, bit, isimcon, bastime, bittime),
      Besincisayfa(),
    ];

    List<Widget> sayfaicon = [];
    for(int i = 0; i < 5; i++){
      if(i == _page) sayfaicon.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: Icon(Icons.brightness_1, size: 15, color: gri,),
      ));
      else sayfaicon.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: Icon(Icons.brightness_1_outlined, size: 15, color: gri,),
      ));
    }
    
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar:  AppBarWidget(context),
      body: Form(
        key: genelcon,
        child: Stack(
          children: [
            Container(
              width: size.width, height: size.height,
              decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/arkafon2.PNG'), fit: BoxFit.cover)),
            ),
            Center(child: pages[_page]),
            AltButonlar(size),
            Positioned(
              top: size.height * 0.05, right: 30,
              child: Row(
                children: sayfaicon,
              ),
            ),
          ]
        ),
      ),
    );
  }

  Column IkinciSayfa(Size size) {
    return Column(
      children: [
        Spacer(flex: 5,),
        GestureDetector(child: BaslanacakSehir(size), onTap: BasSehir,),
        Spacer(flex: 1,),
        GestureDetector(child: BitirilecekSehir(size), onTap: BitSehir,),
        Spacer(flex: 3,),
      ],
    );
  }
  Container BaslanacakSehir(Size size) {
    return Container(
      width: size.width *0.8, height: size.height * 0.1,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(16)), color: gri.withOpacity(0.5),
          border: Border.all(width: 3, color: theme().renk(theme().aciksiyah, dark))
      ),
      child: Center(
        child: Text(bas == null ? localKeys.planhazirlamasayfasi_baslanacaksehir.locale : Sehirler[bas]
            , style: TextStyle(fontSize: 30,)),
      ),
    );
  }
  Container BitirilecekSehir(Size size) {
    return Container(
        width: size.width *0.8, height: size.height * 0.1,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)), color: gri.withOpacity(0.5),
            border: Border.all(width: 3, color: theme().renk(theme().aciksiyah, dark))
        ),
      child: Center(
        child: Text(bit == null ? localKeys.planhazirlamasayfasi_bitirileceksehir.locale : Sehirler[bit]
            , style: TextStyle(fontSize: 30,)),
      ),
    );
  }

  AppBar AppBarWidget(BuildContext context) {
    return AppBar(
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      leading: Container(
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(15), color: theme().renk(theme().Siyah, dark)),
        child: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: theme().renk(theme().Gri, dark),
          ),
          onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => TemelSayfa()));print('geç');},
        ),
      )
    );
  }
  Positioned AltButonlar(Size size) {
    return Positioned(
          bottom: size.height * 0.05, width: size.width,
          child: Row(
            children: [
              Spacer(flex: 1,),
              _page == 0 ? Container(
                height: 50, width: 100,
                decoration: BoxDecoration(borderRadius:
                BorderRadius.horizontal(left: Radius.circular(20)), color: theme().renk(theme().aciksiyah, dark).withOpacity(0.5)),
                child: Center(child: Icon(Icons.arrow_back_outlined, size: 20, color: theme().renk(theme().Gri, dark).withOpacity(0.5),),),
              ) : GestureDetector(
                child: Container(
                  height: 50, width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(left: Radius.circular(20)), color: theme().renk(theme().Siyah, dark)),
                  child: Center(child: Icon(Icons.arrow_back_outlined, size: 20, color: theme().renk(theme().Gri, dark),),),
                ),
                onTap: (){setState(() {_page --;});},
              ),
              Spacer(flex: 2,),
              _page == 4 ? Container(
                height: 50, width: 100,
                decoration: BoxDecoration(borderRadius:
                BorderRadius.horizontal(right: Radius.circular(20)), color: theme().renk(theme().aciksiyah, dark).withOpacity(0.5)),
                child: Center(child: Icon(Icons.arrow_forward, size: 20, color: theme().renk(theme().Gri, dark).withOpacity(0.5),),),
              ) : GestureDetector(
                child: Container(
                  height: 50, width: 100,
                  decoration: BoxDecoration(borderRadius: BorderRadius.horizontal(right: Radius.circular(20)), color: theme().renk(theme().aciksiyah, dark)),
                  child: Center(child: Icon(Icons.arrow_forward, size: 20, color: theme().renk(theme().Gri, dark),),),
                ), onTap: (){setState(() {_page ++;});},
              ),
              Spacer(flex: 1,),
            ],
          ),
        );
  }
  Column IlkSayfa(Size size, BuildContext context) {
    return Column(
    children: [
      Spacer(flex: 5,),
      PlanAdi(size),
      Spacer(flex: 2,),
      bastime == null ? GestureDetector(child: BosBaslangicDate(size), onTap: BasTarih) :
      GestureDetector(child: DoluBaslangicDate(size), onTap: BasTarih),
      Spacer(flex: 1,),
      bittime == null ? GestureDetector(child: BosBitisDate(size), onTap: BitTarih) :
      GestureDetector(child: DoluBitisDate(size), onTap: BitTarih),
      Spacer(flex: 3,),
    ],
  );
  }

  Container DoluBitisDate(Size size) {
    return Container(
            height: size.height*0.08,
            width: size.width*0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)), color: gri.withOpacity(0.5),
                border: Border.all(width: 3, color: theme().renk(theme().aciksiyah, dark))
            ) ,
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Icon(Icons.calendar_today, size: 20, color: Colors.black54,),
                  SizedBox(width: 20,),
                  Text(DateFormat.yMMMd().format(bittime), style: TextStyle(fontSize: 30,)),
                ],
              ),
            ));
  }
  Container BosBitisDate(Size size) {
    return Container(
            height: size.height*0.08,
            width: size.width*0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)), color: gri.withOpacity(0.5),
                border: Border.all(width: 3, color: theme().renk(theme().aciksiyah, dark))
            ) ,
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Icon(Icons.calendar_today, size: 20, color: Colors.black54,),
                  SizedBox(width: 20,),
                  Text(localKeys.planhazirlamasayfasi_bitistarihi.locale, style: TextStyle(fontSize: 30,)),
                ],
              ),
            ));
  }
  Container DoluBaslangicDate(Size size) {
    return Container(
            height: size.height*0.08,
            width: size.width*0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)), color: gri.withOpacity(0.5),
                border: Border.all(width: 3, color: theme().renk(theme().aciksiyah, dark))
            ) ,
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Icon(Icons.calendar_today, size: 20, color: Colors.black54,),
                  SizedBox(width: 20,),
                  Text(DateFormat.yMMMd().format(bastime), style: TextStyle(fontSize: 30,)),
                ],
              ),
            ));
  }
  Container BosBaslangicDate(Size size) {
    return Container(
            height: size.height*0.08,
            width: size.width*0.8,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(16)), color: gri.withOpacity(0.5),
                border: Border.all(width: 3, color: theme().renk(theme().aciksiyah, dark))
            ) ,
            child: Center(
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Icon(Icons.calendar_today, size: 20, color: Colors.black54,),
                  SizedBox(width: 20,),
                  Text(localKeys.planhazirlamasayfasi_baslangictarihi.locale, style: TextStyle(fontSize: 30,)),
                ],
              ),
            ));
  }
  SizedBox PlanAdi(Size size) {
    return SizedBox(
      width: size.width *0.8, height: size.height * 0.13,
      child: TextFormField(
        validator: (name){if(name.isEmpty){return 'please enter your plan name';}},
        controller: isimcon,
        maxLength: 20,
        decoration: InputDecoration(
            fillColor: gri.withOpacity(0.5),
            filled: true,
            labelStyle: TextStyle(
                fontSize: 25, color: aciksiyah
            ),
            labelText: localKeys.planhazirlamasayfasi_planadi.locale,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: theme().renk(theme().aciksiyah, dark), width: 3)),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: theme().renk(theme().aciksiyah, dark), width: 3)),
            suffixIcon: isimcon.text.isEmpty ? Container(width: 0) : IconButton(icon: Icon(Icons.close, color: gri,),
                onPressed: () => isimcon.clear())
        ),
        keyboardType: TextInputType.name,
        textInputAction: TextInputAction.done,
      ),
    );
  }
}