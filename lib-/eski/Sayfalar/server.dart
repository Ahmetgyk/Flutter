import 'package:flutter/material.dart';
import 'dart:io';

List<String> Plansorulari = [
  'Müze ziyaret edecekmisin',
  'Anıt ziyaret edecekmisin',
  'İbadethane ziyaret edecekmisin',
  'Tarihi mekan ziyaret edecekmisin',
  'Turistik mekan ziyaret edecekmisin',
  'Müze ziyaret edecekmisin',
  'Anıt ziyaret edecekmisin',
  'İbadethane ziyaret edecekmisin',
  'Tarihi mekan ziyaret edecekmisin',
  'Turistik mekan ziyaret edecekmisin',
];

List<String> arkafon = [
  'assets/images/kizkul.jpg',
  'assets/images/ayasofya.jpg',
  'assets/images/galatakul.jpg'
];

Map<String, Map<String, dynamic>> MekanMap = {
  'galatakulesi' : galatakul,
  'ayasofya' : ayasofya,
  'kızkulesi' : kizkulesi,
  'anıtkabir' : anitkabir,
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
Map<String, dynamic> anitkabir = {
  'ad' : 'anıtkabir',
  'mekan' : '#Mezar',
  'resim' : 'assets/images/anitkabir2.jpg',
  'yer' : 'Üsküdar/Ankara',
  'renk1' : Colors.blueGrey,
  'renk2' : Colors.blue,
  'puan' : 5.0,
  'tarih' : 'Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
};
Map<String, dynamic> kizkulesi = {
  'ad' : 'kızkulesi',
  'mekan' : '#Restorant',
  'resim' : 'assets/images/kizkul2.jpg',
  'yer' : 'Üsküdar/İstanbul',
  'renk1' : Colors.blueGrey,
  'renk2' : Colors.blue,
  'puan' : 3.4,
  'tarih' : 'Xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx',
};
Map<String, dynamic> ayasofya = {
  'ad' : 'Ayasofya',
  'mekan' : '#İbadethane',
  'resim' : 'assets/images/ayasofya2.jpg',
  'yer' : 'Üsküdar/İstanbul',
  'renk1' : Colors.blueGrey,
  'renk2' : Colors.blue,
  'puan' : 4.2,
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