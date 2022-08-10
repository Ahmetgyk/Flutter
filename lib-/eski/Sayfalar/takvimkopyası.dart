import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_app/init/theme.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/purnurunsayfas.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:table_calendar/table_calendar.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/server.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}
class _HomePageState extends State<HomePage> {
  bool dark = true;

  CalendarController _controller;
  Map<DateTime, List<dynamic>> _events;
  List<dynamic> _selectedEvents;
  TextEditingController _eventController;
  SharedPreferences prefs;

  List<dynamic> plansur = [
  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day - 1),
  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day),
  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 1),
  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 2),
  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 3),
  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 10),
  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 11),
  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 12),
  DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 13)
  ];
  List<dynamic> planbas = [
    DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day - 2),
    DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 4),
    DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 9),
    DateTime(DateTime.now().year,DateTime.now().month,DateTime.now().day + 14)
  ];

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


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      height: size.height, width: size.width,
      color: Color(0xffbC0C0C0),
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
                      selectedColor: theme().renk(theme().Gri, dark),
                      todayStyle: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white)),
                  headerStyle: HeaderStyle(
                    centerHeaderTitle: true,
                    formatButtonVisible: false,
                    formatButtonDecoration: BoxDecoration(
                      color: theme().renk(theme().aciksiyah, dark),
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
                    dayBuilder: (context, date, events){
                      if(plansur.any((e) => e == DateTime(date.year, date.month, date.day))){
                        return Stack(
                          alignment: Alignment.center,
                          children:[
                            Container(color: Colors.transparent,),
                            Container(
                                alignment: Alignment.center,
                                height: 45, width: 60, color: Colors.teal.withOpacity(0.5),
                              child: Text(
                                date.day.toString(),
                                style: TextStyle(color: theme().renk(theme().Gri, dark)),
                              )
                            )
                          ],
                        );
                      }
                      if(planbas.any((e) => e == DateTime(date.year, date.month, date.day))){
                        return Container(
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.teal,
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: theme().renk(theme().Gri, dark)),
                            )
                        );
                      }
                      else{
                        return Container(
                            margin: const EdgeInsets.all(2.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0)),
                            child: Text(
                              date.day.toString(),
                              style: TextStyle(color: theme().renk(theme().Gri, dark)),
                            )
                        );
                      }
                    },
                    selectedDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: theme().renk(theme().Yesil, dark),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: theme().renk(theme().Gri, dark)),
                        )),
                    todayDayBuilder: (context, date, events) => Container(
                        margin: const EdgeInsets.all(4.0),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: theme().renk(theme().Sari, dark),
                            borderRadius: BorderRadius.circular(10.0)),
                        child: Text(
                          date.day.toString(),
                          style: TextStyle(color: theme().renk(theme().Gri, dark)),
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