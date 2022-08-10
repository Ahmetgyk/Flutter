import 'dart:async';

import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';

//Using Bloc
class Themeornek extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: bloc.darkThemeEnabled,
      initialData: false,
      builder: (context, snapshot){
        return MaterialApp(
            home: HomePage());
            });
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final emailcon = TextEditingController();
  final calendarcon = CalendarController();

  bool themedark = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('torkey'),
        actions: [Switch(value: themedark, onChanged: (value){setState(() {themedark = value;});},),],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            DrawerHeader(
              child: CircleAvatar(radius: 40,),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: 400, child: haraket(size)),
            //SizedBox(height: 400, child: plan(size)),
            //SizedBox(height: 400, child: tarih(size)),
            //SizedBox(height: 400, child: login(size)),
            //SizedBox(height: 400, child: email(size)),
            //SizedBox(height: 400, child: card()),
            //SizedBox(height: 400, child: trendcard()),
            //SizedBox(height: 400, child: itemcard(size)),
            //SizedBox(height: 400, child: haraketcard(size)),
            //SizedBox(height: 400, child: takvim()),
          ],
        ),
      ),
    );
  }

  TableCalendar takvim() {
    return TableCalendar(
      calendarController: calendarcon,
      initialCalendarFormat: CalendarFormat.month,
      calendarStyle: CalendarStyle(
          canEventMarkersOverflow: true,
          todayStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18.0,
              color: Colors.white)),
      headerStyle: HeaderStyle(
        centerHeaderTitle: true,
        formatButtonDecoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
        ),
        formatButtonTextStyle: TextStyle(color: Colors.white),
        formatButtonShowsNext: false,
      ),
      startingDayOfWeek: StartingDayOfWeek.monday,
      builders: CalendarBuilders(
        dayBuilder: (context, date, events){
          return Container(
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color: Colors.indigo,
                  borderRadius: BorderRadius.circular(10.0)),
              child: Text(
                date.day.toString(),
                style: TextStyle(color: Colors.white),
              )
          );
        },
        selectedDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              date.day.toString(),
              style: TextStyle(color: Colors.white),
            )),
        todayDayBuilder: (context, date, events) => Container(
            margin: const EdgeInsets.all(4.0),
            alignment: Alignment.center,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0)),
            child: Text(
              date.day.toString(),
            )),
      ),
    );
  }
  Container haraketcard(Size size) {
    return Container(
        width: size.width * 0.7, height: 80,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(width: 3)
        ),
        child: Row(
          children: [
            SizedBox(width: 10),
            SizedBox(
              width: size.width * 0.4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text("selectevent[i][1]", style: TextStyle(fontSize: 20),),
                  SizedBox(height: 10,),
                  Text("selectevent[i][0]", style: TextStyle(fontSize: 20),),
                ],
              ),
            ),
            Container(
                margin: EdgeInsets.all(5),
                width: size.width * 0.2,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(width: 3),
                ),
                child: Center(child: Icon(Icons.camera, size: 30,))
            )
          ],
        )
    );
  }
  Container itemcard(Size size) {
    return Container(
        height: size.width * (0.6), width: size.width,
        child: Stack(
          overflow: Overflow.visible,
          children: [
            Container(
              margin: EdgeInsets.only(left: 10, right: 15, top: 10, bottom: 35),
              decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(40)),
                  image: DecorationImage(image: AssetImage('assets/images/anitkabir2.jpg'), fit: BoxFit.cover)
              ),
            ),
            Positioned(
              bottom: 8, left: size.width * 0.15,
              child: Container(
                  height: size.width * 0.15, width: size.width * 0.7,
                  decoration: BoxDecoration(borderRadius: BorderRadius.vertical(bottom: Radius.circular(30), top: Radius.circular(20)), color: Colors.white),
                  child: Row(
                    children: [
                      SizedBox(width: size.width * 0.35,
                        child:  Row(
                          children: [
                            Icon(Icons.local_fire_department, size: 30,),
                            Text("begeni.toString()", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),),
                          ],
                        ),
                      ),
                      SizedBox(width: size.width * 0.35,
                        child:  Row(
                          children: [
                            Icon(Icons.supervisor_account_outlined, size: 30,),
                            Text("ziyaret.toString()", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25,),),
                          ],
                        ),
                      ),
                    ],
                  )
              ),
            ),
            Positioned(top: 16, left: 20,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("ad", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 40),),
                    Text("sehir", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 25),),
                  ],
                )
            ),
            Positioned(bottom: 70, right: 25,
                child: Row(
                  children: [
                    Column(
                      children: [
                        Text("sicaklik.toString()", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),
                      ],
                    ),
                    SizedBox(width: 10,),
                    SizedBox(height: 40, width: 40, child: Image.asset('assets/images/havadurum.png', fit: BoxFit.cover,)),
                  ],
                )
            ),
          ],
        )
    );
  }
  Container trendcard() {
    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(25))),
      child: Stack(
        overflow: Overflow.visible,
        children: [
          Positioned(bottom: 0, right: 0,
            child: Container(height: 150, width: 200,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(25)),
                  image: DecorationImage(image: AssetImage('assets/images/anitkabir2.jpg'), fit: BoxFit.cover)
              ),
            ),
          ),
          Positioned(top: 0, right: 5,
              child: Column(
                children: [
                  SizedBox(height: 10,),
                  SizedBox(height: 30, width: 30, child: Image.asset('assets/images/havadurum.png', fit: BoxFit.cover,)),
                  SizedBox(height: 5,),
                  Text("sicaklik.toString()", style: TextStyle(fontSize: 20),)
                ],
              )
          ),
          Positioned(top: 0, left: 10,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("ad", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 35),),
                  Text("sehir", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                ],
              )
          ),
          Positioned(bottom: 5, left: 5,
            child: Row(
              children: [
                Icon(Icons.local_fire_department, size: 30,),
                Text("begeni.toString()", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),),
              ],
            ),
          )
        ],
      ),
    );
  }
  Card card() {
    return Card(
        key: ValueKey("_foundUsers[index][id]"),
        elevation: 4,
        margin: EdgeInsets.symmetric(vertical: 10),
        child: ListTile(
            leading: Text("_foundUsers[index][id].toString()", style: TextStyle(fontSize: 30),),
            title: Text("_foundUsers[index]['mekan']", style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800)),
            subtitle: Text("MekanMap[_foundUsers[index]['mekan']]['mekan']", style: TextStyle(fontSize: 20,),),
            trailing: Container(
              width: 80,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/galatakul2.jpg'),),
                  borderRadius: BorderRadius.circular(20)
              ),
            )
        ));
  }
  SizedBox email(Size size) {
    return SizedBox(
      width: size.width *0.8,
      child: TextFormField(
        autofillHints: [AutofillHints.email],
        controller: emailcon,
        decoration: InputDecoration(
            filled: true,
            hintText: 'please enter your email',
            labelText: 'Email',
            prefixIcon: Icon(Icons.email_outlined),
            enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(width: 3)),
            focusedBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(16), borderSide: BorderSide(width: 3)),
            suffixIcon: emailcon.text.isEmpty
                ? Container(width: 0) : IconButton(icon: Icon(Icons.close), onPressed: () => emailcon.clear())
        ),
        keyboardType: TextInputType.emailAddress,
        textInputAction: TextInputAction.done,
      ),
    );
  }
  Container login(Size size) {
    return Container(
        height: size.height*0.07,
        width: size.width*0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)),) ,
        child: Center(
          child: Text('LOGIN', style: TextStyle(fontSize: 30,)),
        )
    );
  }
  Container tarih(Size size) {
    return Container(
        height: size.height*0.08,
        width: size.width*0.8,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(16)),
            border: Border.all(width: 3,)
        ) ,
        child: Center(
          child: Row(
            children: [
              SizedBox(width: 15,),
              Icon(Icons.calendar_today, size: 20,),
              SizedBox(width: 20,),
              Text("DateFormat.yMMMd().format(datetime)", style: TextStyle(fontSize: 30,)),
            ],
          ),
        )
    );
  }
  Stack haraket(Size size) {
    return Stack(
      children: [
        Container(width: size.width, height: 120,),
        Positioned(top: 60, left: 0,
          child: Text('{date.hour}.{date.minute}',
            style: TextStyle(fontSize: 35, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(top: 10, left: 0,
          child: Text('{date.month}/{date.day}',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        Positioned(top: 0, left: 100,
            child: Container(
              width: 8, height: 120,
            )
        ),
        Positioned(top: 10, left: 80,
          child: CircleAvatar(radius: 25, child: Icon(Icons.account_balance_rounded, size: 30, color: theme().renk(1, themedark),),),
        ),
        Positioned(top: 15, left: 140,
            child: Container(
              height: 90, width: 90,
              decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage('assets/images/anitkabir2.jpg'), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10),
                  border: Border.all(width: 5,)
              ),
            )
        ),
        Positioned(top: 20, left: 240,
          child: SizedBox(
            width: 150,
            child: Text("haraket",
              style: TextStyle(fontSize: 20,  fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ],
    );
  }
  Stack plan(Size size) {
    return Stack(
      children: [
        Container(height: 120, width: size.width,),
        Positioned(right: 0,
          child: Container(
            height: 120, width: size.width,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.horizontal(left: Radius.circular(60)),
            ),
          ),
        ),
        Positioned(left: 20, top: 15,
          child : Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 5,),
              Text("planAdi", style: TextStyle(fontSize: 35,),),
              SizedBox(height: 10,),
              Row(
                children: [
                  Text("DateFormat.yMMMd().format(planBas)", style: TextStyle(fontSize: 23,),),
                  SizedBox(width: 10,),
                  Text("DateFormat.yMMMd().format(planBit)", style: TextStyle(fontSize: 23,),),
                ],
              )
            ],
          ),
        ),
        Positioned(right: 40, top: 35,
            child: GestureDetector(
              child: CircleAvatar(
                radius: 27,
                child: Icon(Icons.info_outline, size: 50,),
              ),
            )
        ),
      ],
    );
  }
}

class theme{
  renk(int i, bool dark) {
    Color bir = dark ? Colors.red : Colors.green;
    Color iki = dark ? Colors.black : Colors.blue;
    Color uc = dark ? Colors.yellow : Colors.orange;
    switch(i){
      case 1:
        return bir;
        break;
      case 2:
        return iki;
        break;
      case 3:
        return uc;
        break;
    }
  }
}

class Bloc {
  final _themeController = StreamController<bool>();
  get changeTheme => _themeController.sink.add;
  get darkThemeEnabled => _themeController.stream;
}

final bloc = Bloc();
