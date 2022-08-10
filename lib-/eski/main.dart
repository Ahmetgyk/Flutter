import 'package:email_validator/email_validator.dart';
import 'package:flutter_app/anaSayfa.dart';
import 'package:flutter_app/girisEkrani.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'takvimden.dart';
import 'takvimkopyası.dart';
import 'sehirsayfa.dart';
import 'plansayfa.dart';
import 'purnurunsayfas.dart';
import 'purnursehirsayfa.dart';
import 'profilSayfasi.dart';

import 'package:flutter_app/sqflitescenes/sqfliteanasayfa.dart';

void main() => runApp(MyPage());

class Giris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Login()
    );
  }
}