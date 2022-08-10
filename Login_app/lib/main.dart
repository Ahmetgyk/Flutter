import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:login_app/anasayfa.dart';
import 'package:login_app/testsayfa.dart';
import 'package:provider/provider.dart';
import 'Storageservis.dart';
import 'profilprovider.dart';
import 'TTS.dart';

//Future<void> main() async {WidgetsFlutterBinding.ensureInitialized();await Firebase.initializeApp();runApp(MultiProvider(providers: [ChangeNotifierProvider(create: (context) => CostumProfilData(),),], child: singUpPage(),));}
void main() {runApp(MyApp());}

class singUpPage extends StatefulWidget {
  @override
  statesingUpPage createState() => statesingUpPage();
}

class statesingUpPage extends State<singUpPage> {
  int page = 2;

  final pages = [
    SingUpPage(),
    profilePage(),
    planPage()
  ];

  @override
  Widget build(BuildContext context) {
    // Show the name of the current application locale
    return Text(Localizations.localeOf(context).toString());
  }
}

class states extends State<singUpPage> {
  int page = 2;

  final pages = [
    SingUpPage(),
    profilePage(),
    planPage()
  ];

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: pages[page],
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.home),
            onPressed: (){setState(() {page = 0;});},),label: 'Home', tooltip: 'Home',),
          BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.assignment_late),
            onPressed: (){setState(() {page = 1;});},),label: 'Test', tooltip: 'Test'),
          BottomNavigationBarItem(icon: IconButton(icon: Icon(Icons.map),
            onPressed: (){setState(() {page = 2;});},),label: 'Plan', tooltip: 'Plan')
        ],),
      ),
    );
  }
}