import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_app/init/local_keys.g.dart';
import 'package:flutter_app/init/string_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/init/theme.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/server.dart';

class Sehirarama extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<Sehirarama> {

  bool dark = true;

  final List<Map<String, dynamic>> _allUsers = [
    {"id": 1,'mekan' : 'galatakulesi'},
    {"id": 2, 'mekan' : 'ayasofya'},
    {"id": 3, 'mekan' : 'kızkulesi'},
    {"id": 4, 'mekan' : 'anıtkabir'},
    {"id": 5, 'mekan' : 'galatakulesi'},
    {"id": 6, 'mekan' : 'galatakulesi'},
    {"id": 7, 'mekan' : 'galatakulesi'},
    {"id": 8, 'mekan' : 'galatakulesi'},
    {"id": 9, 'mekan' : 'galatakulesi'},
    {"id": 10, 'mekan' : 'galatakulesi'},
  ];

  // This list holds the data for the list view
  List<Map<String, dynamic>> _foundUsers = [];
  @override
  initState() {
    // at the beginning, all users are shown
    _foundUsers = _allUsers;
    super.initState();
  }

  // This function is called whenever the text field changes
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // if the search field is empty or only contains white-space, we'll display all users
      results = _allUsers;
    } else {
      results = _allUsers
          .where((user) =>
          user['mekan'].toLowerCase().contains(enteredKeyword.toLowerCase()))
          .toList();
      // we use the toLowerCase() method to make it case-insensitive
    }

    // Refresh the UI
    setState(() {
      _foundUsers = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: theme().renk(theme().Siyah, dark),
      appBar: AppBar(
        backgroundColor: theme().renk(theme().aciksiyah, dark),
        title: Text(localKeys.sehiraramasayfasi_baslik.locale, style: TextStyle(color: theme().renk(theme().Gri, dark)),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            SizedBox(height: 20,),
            AramaBari(),
            SizedBox(height: 20,),
            BinaCell(),
          ],
        ),
      ),
    );
  }

  Expanded BinaCell() {
    return Expanded(
            child: _foundUsers.length > 0
                ? ListView.builder(
              itemCount: _foundUsers.length,
              itemBuilder: (context, index) => Card(
                key: ValueKey(_foundUsers[index]["id"]),
                color: theme().renk(theme().Sari, dark),
                elevation: 4,
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ListTile(
                  leading: Text(
                    _foundUsers[index]["id"].toString(),
                    style: TextStyle(fontSize: 30),
                  ),
                  title: Text(_foundUsers[index]['mekan'], style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
                  subtitle: Text(MekanMap[_foundUsers[index]['mekan']]['mekan'], style: TextStyle(fontSize: 20,),),
                  trailing: Container(
                    width: 80,
                    decoration: BoxDecoration(
                      image: DecorationImage(image: AssetImage(MekanMap[_foundUsers[index]['mekan']]['resim'])),
                      borderRadius: BorderRadius.circular(20)
                    ),
                  )
                ),
              ),
            )
                : Text(
              'Öğe bulunamadı',
              style: TextStyle(fontSize: 24, color: theme().renk(theme().Gri, dark)),
            ),
          );
  }
  TextFormField AramaBari() {
    return TextFormField(
            onChanged: (value) => _runFilter(value),
            decoration: InputDecoration(
              fillColor: Color(0xffbC0C0C0),
              filled: true,
              labelText: localKeys.sehiraramasayfasi_sehiradi.locale,
              prefixIcon: Icon(Icons.search),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
              focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(30), borderSide: BorderSide(color: Colors.transparent, width: 3)),
            ),
            keyboardType: TextInputType.name,
            textInputAction: TextInputAction.done,
          );
  }
}