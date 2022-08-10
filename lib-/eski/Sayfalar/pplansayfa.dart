import 'package:flutter/material.dart';
import 'package:flutter_app/init/theme.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/pprogramsayfa.dart';
import 'package:intl/intl.dart';

class PlanSayfa extends StatefulWidget {
  @override
  _sehirsayfaState createState() => _sehirsayfaState();
}
class _sehirsayfaState extends State<PlanSayfa> {

  int p = 0;
  int p2 = 0;

  bool dark = true;

  String planAdi = 'Ankara Planı';
  DateTime planBas = DateTime(2021, 8, 6);
  DateTime planBit = DateTime(2021, 8, 15);
  List<List> planList = [];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<String> adlar = ['İzmir Gezisi', 'Ankara Tatili', 'Kars Kış Tatili', 'Antalya Tatili(aile)', 'Antalya Tatili(arkadaş)', 'İstanbul Turu', 'Muş Proje Ödevi'];
    List<Widget> Plancards = [];
    for(int i = 0; i < 7; i++)
      Plancards.add(GestureDetector(child: PlanCard(i, p, size.width, adlar[i], planBas, planBit, planList, dark),
            onTap: (){setState(() {p = i;});}),);
    Plancards.add(Container(height: 100, width: size.width,),);

    return Container(
      child: Stack(children: [
        Container(
          width: size.width,
          decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/ekran4.PNG'), fit: BoxFit.cover)),
        ),
        Positioned(right: 0, child: Container(height: size.height, width: 40, color: theme().renk(theme().Sari, dark),),),
        SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 100,),
              PlanCard(0, p2, size.width, planAdi, planBas, planBit, planList, dark),
              Column(children: Plancards,),
            ],
          ),
        )
      ],
      ),
    );
  }
}
class PlanCard extends StatelessWidget {
  int i;
  int g;
  double w;
  String planAdi;
  DateTime planBas;
  DateTime planBit;
  List<List> planList;
  bool dark;

  PlanCard(this.i, this.g, this.w, this.planAdi, this.planBas, this.planBit, this.planList, this.dark);

  @override
  Widget build(BuildContext context) {
    if(i == g){
      return Stack(
        children: [
          Container(height: 120, width: w,),
          Positioned(right: 0,
            child: Container(
              height: 120, width: w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.horizontal(left: Radius.circular(60)),
                color: theme().renk(theme().Sari, dark),
              ),
            ),
          ),
          Positioned(left: 20, top: 15,
            child : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 5,),
                Text(planAdi, style: TextStyle(fontSize: 35, color: theme().renk(theme().aciksiyah, dark)),),
                SizedBox(height: 10,),
                Row(
                  children: [
                    Text(DateFormat.yMMMd().format(planBas),
                      style: TextStyle(fontSize: 23, color: theme().renk(theme().Yesil, dark)),),
                    SizedBox(width: 10,),
                    Text(DateFormat.yMMMd().format(planBit),
                      style: TextStyle(fontSize: 23, color: theme().renk(theme().Kirmizi, dark)),),
                  ],
                )
              ],
            ),
          ),
          Positioned(right: 40, top: 35,
              child: GestureDetector(
                child: CircleAvatar(
                  radius: 27,
                  backgroundColor: theme().renk(theme().aciksiyah, dark),
                  child: Icon(Icons.info_outline, size: 50, color: theme().renk(theme().Gri, dark),),
                ),
                onTap: (){ Navigator.push(context, MaterialPageRoute(builder: (context) => ProgramSayfasi()));},
              )
          ),
        ],
      );
    }
    else{
      return Stack(
        children: [
          Container(height: 80, width: w,),
          Positioned(right: 0,
            child: GestureDetector(
              child: Container(height: 120, width: 40, color: theme().renk(theme().Sari, dark),),
              onTap: (){},
            ),
          ),
          Positioned(right: 50, top: 40, child: Text(planAdi,
            style: TextStyle(fontSize: 30, color: theme().renk(theme().Sari, dark), fontWeight: FontWeight.bold),),),
          Positioned(right: 10, top: 50, child: Icon(Icons.circle, size: 20, color: theme().renk(theme().aciksiyah, dark),)),
        ],
      );
    }
  }
}