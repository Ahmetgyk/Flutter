import 'package:flutter/material.dart';

class CostumProfilData extends ChangeNotifier{
  Map<String, dynamic> _profilData = Map<String, dynamic>();

  String name = 'name';
  String email = 'email';
  String password = 'password';
  String id = 'id';
  String date = 'date';

  Map<String, dynamic> get getProfilData => _profilData;

  void setProfiData (Map<String, dynamic> data) {
    _profilData = data;
    notifyListeners();
  }
}