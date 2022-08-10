import 'package:flutter/material.dart';

DateTime date = DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day - 1);

Map<String, IconData> eveticon = {
  'baslangic' : Icons.flight_takeoff,
  'gezi' : Icons.account_balance_rounded,
  'otel' : Icons.hotel_rounded,
  'yemek' : Icons.restaurant,
  'bitis' : Icons.flight_land,
};

List<dynamic> aktiveEvent = ['Ayasofya ziyareti', '14.30', 'gezi', 'ayasofya'];

Map<DateTime, List<dynamic>> events = {
  DateTime(2021, 8, 23) : [['i', '10.30', 'baslangic'], ['2', '12.30', 'gezi'] ,['3', '14.30', 'gezi'],],
  DateTime(2021, 8, 24) : [['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
  DateTime(2021, 8, 25) : [['i', '10.30', 'baslangic'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
  DateTime(2021, 8, 26) : [['i', '10.30', 'baslangic'], ['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'],['7', '22.00', 'bitis']],
  DateTime(2021, 8, 27) : [['2', '12.30', 'gezi'] ,['3', '14.30', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
  DateTime(2021, 8, 28) : [['i', '10.30', 'baslangic'],['3', '14.30', 'gezi'], ['5', '17.00', 'gezi'], ['7', '22.00', 'bitis']],
  DateTime(2021, 8, 29) : [['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis']],
};
List<dynamic> selectevent = [['4', '16.30', 'gezi'], ['5', '17.00', 'gezi'], ['6', '19.30', 'gezi'], ['7', '22.00', 'bitis'],];

String columnYer = 'yer';
String columnHaraket = 'haraket';
String columnIcon = 'icon';
String columnBaslandic = 'baslangic';
String columnBiris = 'bitis';

List<Map<String, dynamic>> planmap = [
  {
    "yer" : "",
    "haraket" : "tatil başlıyooooor!!!",
    "icon" : "baslangic",
    "baslangic" : DateTime(2021, 9, 11, 15).toIso8601String(),
    "bitis" : ""
  },
  {
    "yer" : "ayasofya",
    "haraket" : "ayasofyayı ziyaret",
    "icon" : "gezi",
    "baslangic" : DateTime(2021, 9, 11, 16).toIso8601String(),
    "bitis" : DateTime(2021, 9, 11, 17, 30).toIso8601String()
  },
  {
    "yer" : "restorant XXX",
    "haraket" : "yemek vakti",
    "icon" : "yemek",
    "baslangic" : DateTime(2021, 9, 12, 18).toIso8601String(),
    "bitis" : DateTime(2021, 9, 12, 19).toIso8601String()
  },
  {
    "yer" : "kızkulesi",
    "haraket" : "kız kulesini ziyaret",
    "icon" : "gezi",
    "baslangic" : DateTime(2021, 9, 12, 19).toIso8601String(),
    "bitis" : DateTime(2021, 9, 12, 20, 35).toIso8601String()
  },
  {
    "yer" : "ottel XXX",
    "haraket" : "yatma vakti",
    "icon" : "otel",
    "baslangic" : DateTime(2021, 9, 13, 21).toIso8601String(),
    "bitis" : DateTime(2021, 9, 13, 9).toIso8601String()
  },
  {
    "yer" : "",
    "haraket" : "malesef tatilin sonuna geldik :(",
    "icon" : "bitis",
    "baslangic" : DateTime(2021, 9, 13, 15).toIso8601String(),
    "bitis" : ""
  }
];

List<Map<String, dynamic>> planlar = [
  {
    "ad" : "Ankaraplani",
    "baslangicsehir" : 'kızkulesi',
    "bitissehir" : 'anıtkabir',
    "baslangictarih" : DateTime(2021, 9, 11, 15).toIso8601String(),
    "bitistarih" : DateTime(2021, 11, 13, 15).toIso8601String()
  },
  {
    "ad" : "Kayseriplani",
    "baslangicsehir" : 'kızkulesi',
    "bitissehir" : 'anıtkabir',
    "baslangictarih" : DateTime(2021, 11, 11, 16).toIso8601String(),
    "bitistarih" : DateTime(2021, 12, 11, 17, 30).toIso8601String()
  },
  {
    "ad" : "Izmirplani",
    "baslangicsehir" : 'kızkulesi',
    "bitissehir" : 'anıtkabir',
    "baslangictarih" : DateTime(2022, 9, 11, 16).toIso8601String(),
    "bitistarih" : DateTime(2022, 10, 11, 17, 30).toIso8601String()
  },
];
List<Map<String, dynamic>> Ankaraplani = [
  {
    "yer" : "",
    "haraket" : "tatil başlıyooooor!!!",
    "icon" : "baslangic",
    "baslangic" : DateTime(2021, 9, 11, 15).toIso8601String(),
    "bitis" : ""
  },
  {
    "yer" : "ayasofya",
    "haraket" : "ayasofyayı ziyaret",
    "icon" : "gezi",
    "baslangic" : DateTime(2021, 9, 11, 16).toIso8601String(),
    "bitis" : DateTime(2021, 9, 11, 17, 30).toIso8601String()
  },
  {
    "yer" : "restorant XXX",
    "haraket" : "yemek vakti",
    "icon" : "yemek",
    "baslangic" : DateTime(2021, 9, 12, 18).toIso8601String(),
    "bitis" : DateTime(2021, 9, 12, 19).toIso8601String()
  },
  {
    "yer" : "kızkulesi",
    "haraket" : "kız kulesini ziyaret",
    "icon" : "gezi",
    "baslangic" : DateTime(2021, 9, 12, 19).toIso8601String(),
    "bitis" : DateTime(2021, 9, 12, 20, 35).toIso8601String()
  },
  {
    "yer" : "ottel XXX",
    "haraket" : "yatma vakti",
    "icon" : "otel",
    "baslangic" : DateTime(2021, 9, 13, 21).toIso8601String(),
    "bitis" : DateTime(2021, 9, 13, 9).toIso8601String()
  },
  {
    "yer" : "",
    "haraket" : "malesef tatilin sonuna geldik :(",
    "icon" : "bitis",
    "baslangic" : DateTime(2021, 9, 13, 15).toIso8601String(),
    "bitis" : ""
  }
];
List<Map<String, dynamic>> Kayseriplani = [
  {
    "yer" : "",
    "haraket" : "tatil başlıyooooor!!!",
    "icon" : "baslangic",
    "baslangic" : DateTime(2021, 9, 11, 15).toIso8601String(),
    "bitis" : ""
  },
  {
    "yer" : "ayasofya",
    "haraket" : "ayasofyayı ziyaret",
    "icon" : "gezi",
    "baslangic" : DateTime(2021, 9, 11, 16).toIso8601String(),
    "bitis" : DateTime(2021, 9, 11, 17, 30).toIso8601String()
  },
  {
    "yer" : "restorant XXX",
    "haraket" : "yemek vakti",
    "icon" : "yemek",
    "baslangic" : DateTime(2021, 9, 12, 18).toIso8601String(),
    "bitis" : DateTime(2021, 9, 12, 19).toIso8601String()
  },
  {
    "yer" : "kızkulesi",
    "haraket" : "kız kulesini ziyaret",
    "icon" : "gezi",
    "baslangic" : DateTime(2021, 9, 12, 19).toIso8601String(),
    "bitis" : DateTime(2021, 9, 12, 20, 35).toIso8601String()
  },
  {
    "yer" : "ottel XXX",
    "haraket" : "yatma vakti",
    "icon" : "otel",
    "baslangic" : DateTime(2021, 9, 13, 21).toIso8601String(),
    "bitis" : DateTime(2021, 9, 13, 9).toIso8601String()
  },
  {
    "yer" : "",
    "haraket" : "malesef tatilin sonuna geldik :(",
    "icon" : "bitis",
    "baslangic" : DateTime(2021, 9, 13, 15).toIso8601String(),
    "bitis" : ""
  }
];
List<Map<String, dynamic>> Izmirplani = [
  {
    "yer" : "",
    "haraket" : "tatil başlıyooooor!!!",
    "icon" : "baslangic",
    "baslangic" : DateTime(2021, 9, 11, 15).toIso8601String(),
    "bitis" : ""
  },
  {
    "yer" : "ayasofya",
    "haraket" : "ayasofyayı ziyaret",
    "icon" : "gezi",
    "baslangic" : DateTime(2021, 9, 11, 16).toIso8601String(),
    "bitis" : DateTime(2021, 9, 11, 17, 30).toIso8601String()
  },
  {
    "yer" : "restorant XXX",
    "haraket" : "yemek vakti",
    "icon" : "yemek",
    "baslangic" : DateTime(2021, 9, 12, 18).toIso8601String(),
    "bitis" : DateTime(2021, 9, 12, 19).toIso8601String()
  },
  {
    "yer" : "kızkulesi",
    "haraket" : "kız kulesini ziyaret",
    "icon" : "gezi",
    "baslangic" : DateTime(2021, 9, 12, 19).toIso8601String(),
    "bitis" : DateTime(2021, 9, 12, 20, 35).toIso8601String()
  },
  {
    "yer" : "ottel XXX",
    "haraket" : "yatma vakti",
    "icon" : "otel",
    "baslangic" : DateTime(2021, 9, 13, 21).toIso8601String(),
    "bitis" : DateTime(2021, 9, 13, 9).toIso8601String()
  },
  {
    "yer" : "",
    "haraket" : "malesef tatilin sonuna geldik :(",
    "icon" : "bitis",
    "baslangic" : DateTime(2021, 9, 13, 15).toIso8601String(),
    "bitis" : ""
  }
];