import 'package:flutter/material.dart';
import 'dart:io';

class ArkadasProf{
  final String ad, resim;
  ArkadasProf({this.ad, this.resim});
}
class Profil{
  String ad;
  File resin;
  ArkadasProf arkadas;
  bool kayitoldu;
  Profil({this.ad, this.resin, this.arkadas, this.kayitoldu});

  Map<String, String> _ad={'ad' : null};
  Map<String, File> _resim={'resim' : null};
}

Map<DateTime, List<String>> takvim = {
  DateTime(2021, 8, 7) : ['7/8/1', '7/8/2','7/8/3'],
  DateTime(2021, 8, 8) : ['8/8/1', '8/8/2'],
  DateTime(2021, 8, 9) : ['9/8/1',],
};

List<String> arkafon = [
  'assets/images/kizkul.jpg',
  'assets/images/ayasofya.jpg',
  'assets/images/galatakul.jpg'
];

Map<String, List> bildirimler = {
  '1.bil' : ['1.bildirim', '1.bildirimin açıklaması'],
  '2.bil' : ['2.bildirim', '2.bildirimin açıklaması'],
  '3.bil' : ['3.bildirim', '3.bildirimin açıklaması'],
};

Map<String, dynamic> profil = {
  'ad' : 'Murat',
  'email' : 'murat@gmail.com',
  'resim' : File('/data/user/0/com.example.tourkey_app/cache/image_picker3565943304780944396.jpg'),
  'dogutarihi' : DateTime(2021, 8, 9),
};

Map<String, dynamic> galatakul = {
  'ad' : 'Galata Kulesi',
  'mekan' : '#Restoran',
  'resim' : 'assets/images/galatakul2.jpg',
  'yer' : 'Üsküdar/İstanbul',
  'renk1' : Colors.blueGrey,
  'renk2' : Colors.blue,
  'puan' : 4.6,
  'tarih' : 'Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
};

List<List> kopyabina=[
  ['Ankara', 'Başkent', 'assets/images/anitkabir.jpg', 120.654, 346.782,
    'assets/images/havadurum.png', 25.6,
    Colors.blueGrey, Color(0xffb333533), 'Yyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyyy',
    3.4,
    [
      ['assets/images/kahve.jpg', 'Kullanıcı1', 3.2, DateTime(2021, 6, 5), 'Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'],
      ['assets/images/kahve.jpg', 'Kullanıcı2', 5.0, DateTime(2021, 6, 4), 'Aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa'],
      ['assets/images/kahve.jpg', 'Kullanıcı3', 3.8, DateTime(2021, 8, 5), 'Mesaj3'],
      ['assets/images/kahve.jpg', 'Kullanıcı4', 4.1, DateTime(2021, 11, 7), 'Mesaj4'],
      ['assets/images/kahve.jpg', 'Kullanıcı5', 2.9, DateTime(2021, 9, 12), 'Mesaj5'],
    ],
    [
      ['Galata Kulesi', '#Restoran', 'assets/images/galatakul2.jpg', 'Üsküdar/İstanbul', Colors.blueGrey, Colors.blue, 4.6,
        'Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'],
      ['Galata Kulesi', '#Restoran', 'assets/images/galatakul2.jpg', 'Üsküdar/İstanbul', Colors.blueGrey, Colors.blue, 1.5,
        'Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'],
      ['Galata Kulesi', '#Restoran', 'assets/images/galatakul2.jpg', 'Üsküdar/İstanbul', Colors.blueGrey, Colors.blue, 2.8,
        'Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'],
      ['Galata Kulesi', '#Restoran', 'assets/images/galatakul2.jpg', 'Üsküdar/İstanbul', Colors.blueGrey, Colors.blue, 3.3,
        'Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'],
      ['Galata Kulesi', '#Restoran', 'assets/images/galatakul2.jpg', 'Üsküdar/İstanbul', Colors.blueGrey, Colors.blue, 5.0,
        'xxx'],
    ],
  ],
];

List<List> binalist = [
  ['A binasi', Colors.indigo, 'assets/images/anitkabir.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, '#Restoran'],
  ['B binası', Colors.red, 'assets/images/kizkul.jpg', 'assets/images/kizkul2.jpg', 'Binanın tarihi', 2, '#Kafe'],
  ['C binası', Colors.deepPurple, 'assets/images/ayasofya.jpg', 'assets/images/ayasofya2.jpg', 'Binanın tarihi', 4, '#Müze'],
  ['A binası', Colors.indigo, 'assets/images/galatakul.jpg', 'assets/images/galatakul2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
  ['A binası', Colors.indigo, 'assets/images/kahve.jpg', 'assets/images/anitkabir2.jpg', 'Binanın tarihi', 3, 'Restoran'],
];
List<String> binalar = [
  'A Binası','B Binası','C Binası','D Binası','E Binası','F Binası',
  'G Binası','H Binası','I Binası','J Binası','K Binası','L Binası',
  'M Binası','N Binası','O Binası','P Binası','R Binası','S Binası',
  'T Binası','U Binası','V Binası','Y Binası','Z Binası','X Binası',
  'Q Binası','W Binası',
];
List<String> sehirler = [
  'A Sehri','B Sehri','C Sehri','D Sehri','E Sehri','F Sehri',
  'G Sehri','H Sehri','I Sehri','J Sehri','K Sehri','L Sehri',
  'M Sehri','N Sehri','O Sehri','P Sehri','R Sehri','S Sehri',
  'T Sehri','U Sehri','V Sehri','Y Sehri','Z Sehri','X Sehri',
  'Q Sehri','W Sehri',
];

class Arkadas{
  final String ad, resim;
  Arkadas({this.ad, this.resim});
}
List<Arkadas> Arkadaslar = [Ark1, Ark2, Ark3, Ark4, Ark5];
Arkadas Ark1 = Arkadas(ad: 'Ahmet', resim: 'A');
Arkadas Ark2 = Arkadas(ad: 'Mehmet', resim: 'M');
Arkadas Ark3 = Arkadas(ad: 'Rumeysa', resim: 'R');
Arkadas Ark4 = Arkadas(ad: 'Hüseyin', resim: 'H');
Arkadas Ark5 = Arkadas(ad: 'Sinem', resim: 'S');

class PlanSema{
  final String isim, resim;
  final DateTime zaman;
  final List<Arkadas> arkadas;
  PlanSema({this.isim, this.resim, this.zaman, this.arkadas});
}
List<PlanSema> plansemalari = [
  PlanSema(isim: 'Plan1', resim: 'assets/images/anitkabir.jpg', zaman: DateTime(2020, 10, 17), arkadas: [Arkadaslar[0], Arkadaslar[1],]),
  PlanSema(isim: 'Plan2', resim: 'assets/images/kizkul.jpg', zaman: DateTime(2020, 5, 2), arkadas: [Arkadaslar[1], Arkadaslar[2],]),
  PlanSema(isim: 'Plan3', resim: 'assets/images/anitkabir.jpg', zaman: DateTime(2020, 8, 10), arkadas: [Arkadaslar[3], Arkadaslar[4],]),
  PlanSema(isim: 'Plan4', resim: 'assets/images/anitkabir.jpg', zaman: DateTime(2020, 2, 1), arkadas: [Arkadaslar[0], Arkadaslar[3],]),
  PlanSema(isim: 'Plan5', resim: 'assets/images/anitkabir.jpg', zaman: DateTime(2020, 5, 24), arkadas: [Arkadaslar[2], Arkadaslar[4],]),
];