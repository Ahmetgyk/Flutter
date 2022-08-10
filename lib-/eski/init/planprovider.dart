import 'package:flutter/material.dart';
import 'package:flutter_app/Sayfalar/planserver.dart';

class PlanData extends ChangeNotifier{
  Map<String, dynamic> _gununplani;

  Map<String, dynamic> get getgunuplani => _gununplani;

  void setPlanData () {
    print('hfthfth');
    List<Map<String, dynamic>> yil = [];
    for(int i = 0; i < planlar.length; i ++){
      DateTime bas = DateTime.parse(planlar[i]["baslangic"]);
      DateTime bit = DateTime.parse(planlar[i]["bitis"]);
      if(bas.year >= DateTime.now().year && bit.year <= DateTime.now().year){
        yil.add(planlar[i]);
      }
    }
    List<Map<String, dynamic>> ay = [];
    for(int i = 0; i < yil.length; i ++){
      DateTime bas = DateTime.parse(yil[i]["baslangic"]);
      DateTime bit = DateTime.parse(yil[i]["bitis"]);
      if(bas.year >= DateTime.now().year && bit.year <= DateTime.now().year){
        ay.add(yil[i]);
      }
    }
    for(int i = 0; i < ay.length; i ++){
      DateTime bas = DateTime.parse(ay[i]["baslangic"]);
      DateTime bit = DateTime.parse(ay[i]["bitis"]);
      if(bas.year >= DateTime.now().year && bit.year <= DateTime.now().year){
        _gununplani = ay[i];
      }
    }
    notifyListeners();
  }
}