import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/GirisEkrani/girisekraniview.dart';
import 'package:flutter/material.dart';
class Login extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: login(),
    );
  }
}
class login extends StatefulWidget {
  @override
  Loginview  createState() => new Loginview();
}