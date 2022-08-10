import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/server.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:login_app/profilprovider.dart';
import 'package:provider/provider.dart';


class profilePage extends StatefulWidget {
  @override
  _State createState() => _State();
}
Future<Widget> callAsyncFetch(BuildContext context) => Future.delayed(Duration(seconds: 2), () async {
  Color siya = Color(0xff222831);

  Map<String, dynamic> profilData = Provider.of<CostumProfilData>(context, listen: false).getProfilData;
  String name = Provider.of<CostumProfilData>(context, listen: false).name;
  String email = Provider.of<CostumProfilData>(context, listen: false).email;
  String password = Provider.of<CostumProfilData>(context, listen: false).password;
  String id = Provider.of<CostumProfilData>(context, listen: false).id;
  String date = Provider.of<CostumProfilData>(context, listen: false).date;

  Future<String> plan() async {
    Map<String, dynamic> profilData = Provider.of<CostumProfilData>(context, listen: false).getProfilData;
    String id = Provider.of<CostumProfilData>(context, listen: false).id;

    var res = await FirebaseFirestore.instance.collection("kullanicilar").doc(profilData[id])
        .collection("planlar").doc("${profilData[id]}.plan").get();
    String planadi = res.data()["planadi"]["planadi"];

    return planadi;
  }

  Future<Widget> Plangosterme(BuildContext context) async {
    String planadi = await plan();
    return Container(
        height: MediaQuery.of(context).size.height*0.08,
        color: Colors.grey,
        child: Center(
          child: Text('${planadi}', style: TextStyle(fontSize: 30,)),
        )
    );
  }
  Material DogumTarihiDegistirme(BuildContext context, String datetime) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          height: MediaQuery.of(context).size.height*0.08,
          color: Colors.grey,
          child: Center(
            child: Text('${DateFormat.yMMMd().format(DateTime.parse(datetime))}'
                , style: TextStyle(fontSize: 30,)),
          )),
    );
  }
  Material IdDegistirme(String id) {
    return Material(
      elevation: 6,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          height: MediaQuery.of(context).size.height*0.08,
          color: Colors.grey,
          child: Center(
            child: Text(id.toString(), style: TextStyle(fontSize: 20,)),
          )),
    );
  }
  Material MailDegistirme(String email) {
    return Material(
      elevation: 4,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          height: MediaQuery.of(context).size.height*0.08,
          color: Colors.grey,
          child: Center(
            child: Text(email, style: TextStyle(fontSize: 30,)),
          )),
    );
  }
  Material IsimDegistirme(String isim) {
    return Material(
      elevation: 6,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          height: MediaQuery.of(context).size.height*0.08,
          color: Colors.grey,
          child: Center(
            child: Text(isim, style: TextStyle(fontSize: 30,)),
          )),
    );
  }
  Material ParolaDegistirme(String parola) {
    return Material(
      elevation: 6,
      shadowColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
          height: MediaQuery.of(context).size.height*0.08,
          color: Colors.grey,
          child: Center(
            child: Text(parola, style: TextStyle(fontSize: 30,)),
          )),
    );
  }

  return Container(
    color: siya,
    height: MediaQuery.of(context).size.height - 80,
    child: Stack(
      children: [
        Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                height: 450,
                width: double.infinity,
                margin: EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IsimDegistirme(profilData[name]),
                    MailDegistirme(profilData[email]),
                    ParolaDegistirme(profilData[password]),
                    IdDegistirme(profilData[id]),
                    DogumTarihiDegistirme(context, profilData[date]),
                    await Plangosterme(context),
                    GestureDetector(
                      child: Material(
                        elevation: 6,
                        shadowColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Container(
                            height: MediaQuery.of(context).size.height*0.08,
                            color: Colors.green,
                            child: Center(
                              child: Text("değiştir", style: TextStyle(fontSize: 30,)),
                            )),
                      ),
                      onTap: (){},
                    )
                  ],
                ),
              ),
              SizedBox(height: 20,)
            ],
          ),
        ),
      ],
    ),
  );
});

class _State extends State<profilePage> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Widget>(
        future: callAsyncFetch(context),
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data;
          } else {
            return Center(child: CircularProgressIndicator());
          }
        }
    );
  }
}