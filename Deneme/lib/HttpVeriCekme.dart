import 'dart:convert';
import 'package:url_launcher_web/url_launcher_web.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';

class httpVeriCekme extends StatefulWidget {
  @override
  _httpVeriCekmeState createState() => _httpVeriCekmeState();
}
class _httpVeriCekmeState extends State<httpVeriCekme> {
  String _cevap;
  AnlikGunlukSaat _anlikGunlukSaat;

  Future<void> _incrementCounter() async{
    String adres = "https://api.openweathermap.org/data/2.5/onecall?lat=33.44&lon=-94.04&exclude=hourly&appid=e6460b4319ce8541c3c9ed2223acdf59";
    Response cevap = await get(Uri.parse(adres));

    if(cevap.statusCode == 200){
      Map gelenJson = jsonDecode(cevap.body);
      _anlikGunlukSaat = AnlikGunlukSaat.fromJson(gelenJson);
      _cevap = gelenJson["current"]["weather"][0]["icon"];
    }
    else
      _cevap = "Bağlanamadı";
    setState(() {});
  }

  Future<void> _loremimput() async{
    String adres = "https://baconipsum.com/api/?type=all-meat&paras=3&start-with-lorem=0&format=json";
    Response cevapli = await get(Uri.parse(adres));

    if(cevapli.statusCode == 200){
      List gelenJsonli = jsonDecode(cevapli.body);
      _cevap = gelenJsonli[0];
    }
    else
      _cevap = "Bağlanamadı";

    setState(() {});
  }

  @override
  void initState() {_loremimput();}

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      home: Scaffold(
        body: Center(
          child: Column(
            children: [
              _cevap == null? SizedBox() : Text(_cevap),
              // if(_anlikGunlukSaat != null)
              //   Text(_anlikGunlukSaat.anlik.hava[0].icon),
              //   for(Hava hava in _anlikGunlukSaat.anlik.hava)
              //     Text(hava.olay),
              //   Text(_anlikGunlukSaat.anlik.sicaklik.maks.toString())
            ],
          ),
        ),
      ),
    );
  }
}

class AnlikGunlukSaat{
  double enlem;
  double boylam;
  String zamanDilimi;

  Anlik anlik;
  List saatlik;
  List<Anlik> gunluk;

  AnlikGunlukSaat.fromJson(Map json){
    this.enlem = json["lat"];
    this.boylam = json["lon"];
    this.zamanDilimi = json["timezone"];
    this.anlik = Anlik.fromJson(json["current"]);
    this.saatlik = json["minutely"];
    this.gunluk = (json["daily"] ?? []).map((e) => Anlik.fromJson(e)).toList().cast<Anlik>();
  }
}

class Anlik{
  Sicaklik sicaklik;
  int zaman;

  List<Hava> hava;

  Anlik.fromJson(Map json){
    this.sicaklik = Sicaklik.fromJson((json["temp"] is double) ? {"max" : json["temp"]} : json["temp"]);
    this.zaman = json["dt"];
    this.hava = (json["weather"] ?? []).map((e) => Hava.fromJson(e)).toList().cast<Hava>();
  }
}

class Hava{
  int id;
  String olay;
  String icon;

  Hava.fromJson(Map json){
    this.id = json["id"];
    this.olay = json["main"];
    this.icon = json["icon"];
  }
}

class Sicaklik{
  double maks;

  Sicaklik.fromJson(Map json){
    this.maks = json["max"];
  }
}