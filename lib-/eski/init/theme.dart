import 'package:flutter/material.dart';

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

class theme{
  var Siyah = 'siyah';
  var Gri = 'gri';
  var Kirmizi = 'kirmizi';
  var Yesil = 'yesil';
  var Sari = 'sari';
  var aciksiyah = 'aciksiyah';

  renk(String i, bool dark) {
    Color siyah = dark ? siya : beyaz;
    Color aciksiyah = dark ? aciksiya : gir;
    Color gri = dark ? gr : koyugri;
    Color kirmizi = dark ? kirmiz : kirmiz;
    Color yesil = dark ? yesi : yesi;
    Color sari = dark ? sar : lacivert;
    switch(i){
      case 'siyah':
        return siyah;
        break;
      case 'aciksiyah':
        return aciksiyah;
      case 'gri':
        return gri;
        break;
      case 'kirmizi':
        return kirmizi;
      case 'yesil':
        return yesil;
      case 'sari':
        return sari;
        break;
    }
  }
}

ThemeData lighttheme = ThemeData(
    primaryColor: Color(0xffC6DE41),
    secondaryHeaderColor: Color(0xff30475E),
    accentColor: Color(0xff333333),
    cardColor: Color(0xff990100),
    backgroundColor: Color(0xffE8E8E8),
    scaffoldBackgroundColor: Color(0xffD6D6D6)
);
ThemeData darktheme = ThemeData(
  primaryColor:  Color(0xff222831),
  secondaryHeaderColor: Color(0xff30475E),
  accentColor: Color(0xffC6DE41),
  cardColor: Color(0xff990100),
  backgroundColor: Color(0xffDDDDDD),
  scaffoldBackgroundColor: Color(0xffFCA311)
);