import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/purnurunsayfas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:flutter_app/server.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {

  Color siyah = Color(0xffb202020);
  Color aciksiyah = Color(0xffb333533);
  Color gri = Color(0xffbD6D6D6);
  Color aciksari = Color(0xffbFFEE32);
  Color sari = Color(0xffbFFD100);

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  @override
  void initState() {
    super.initState();
    _controller = CalendarController();
    _eventController = TextEditingController();
    _events = {};
    _selectedEvents = [];
    initPrefs();
  }

  initPrefs() async {
    prefs = await SharedPreferences.getInstance();
    setState(() {
      _events = Map<DateTime, List<dynamic>>.from(
          decodeMap(json.decode(prefs.getString("events") ?? "{}")));
    });
  }

  Map<String, dynamic> encodeMap(Map<DateTime, dynamic> map) {
    Map<String, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[key.toString()] = map[key];
    });
    return newMap;
  }

  Map<DateTime, dynamic> decodeMap(Map<String, dynamic> map) {
    Map<DateTime, dynamic> newMap = {};
    map.forEach((key, value) {
      newMap[DateTime.parse(key)] = map[key];
    });
    return newMap;
  }

  _profil(){
    if(profil['resim'] == null)
      return Container(
          width: 60,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: AssetImage('assets/images/kahve.jpg'), fit: BoxFit.cover),
              border: Border.all(color: siyah, width: 5)
          ),
          child: Icon(Icons.account_circle, color: Colors.grey,)
      );
    else
      return Container(
        width: 60,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            image: DecorationImage(image: FileImage(profil['resim']), fit: BoxFit.cover),
            border: Border.all(color: siyah, width: 5)
        ),
      );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    bool thema = true;

    return Container(
      height: size.height, width: size.width,
      color: gri,
      child: Column(
        children: [
          SizedBox(height: 80,),
          SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                TableCalendar(
                  events: _events,
                  initialCalendarFormat: CalendarFormat.month,
                  calendarStyle: CalendarStyle(
                      canEventMarkersOverflow: true,
                      selectedColor: gri,
                      todayStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white)),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonDecoration: BoxDecoration(
                      color: aciksiyah,
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    formatButtonTextStyle: TextStyle(color: Colors.white),
                    formatButtonShowsNext: false,
                  ),
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  onDaySelected: (date, events, event) {
                    setState(() {
                      _selectedEvents = events;
                    });
                  },
                  builders: CalendarBuilders(
                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: aciksiyah,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: Colors.white),
                        )),
                    todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: sari,
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: aciksari),
                        )),
                  ),
                  calendarController: _controller,
                ),
                Column(children: _selectedEvents.map((event) => ListTile(
                  title: Text(event),
                )).toList(),)
              ],
            ),
          ),
        ],
      ),
    );
  }

  _showAddDialog() async {
    await showDialog(
        context: context,
        builder: (context) => AlertDialog(
          content: TextField(
            controller: _eventController,
          ),
          actions: <Widget>[
            FlatButton(
              child: Text("Save"),
              onPressed: () {
                if (_eventController.text.isEmpty) return;
                if (_events[_controller.selectedDay] != null) {
                  _events[_controller.selectedDay]
                      .add(_eventController.text);
                } else {
                  _events[_controller.selectedDay] = [
                    _eventController.text
                  ];
                }
                prefs.setString("events", json.encode(encodeMap(_events)));
                _eventController.clear();
                Navigator.pop(context);
              },
            )
          ],
        ));
    setState(() {
      _selectedEvents = _events[_controller.selectedDay];
    });
  }
}