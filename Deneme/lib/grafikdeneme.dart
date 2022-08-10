import 'package:deneme/SehirBilgi.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color siya = Color(0xff222831);
Color gr = Color(0xffDDDDDD);
Color aciksiya = Color(0xff333533);
Color kirmiz = Color(0xff990100);
Color yesi = Color(0xffC6DE41);
Color lacivert = Color(0xff30475E);

class Grafikdeneme extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: grafikdeneme(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class grafikdeneme extends StatefulWidget {
  @override
  _grafikdenemeState createState() => _grafikdenemeState();
}
class _grafikdenemeState extends State<grafikdeneme> {
  List<List<double>> data = [[45, 86], [93, 48], [88, 45], [67, 87], [68, 86], [68, 58], [12, 52], [45, 86], [93, 48], [88, 45], [67, 87], [68, 86], [68, 58], [12, 52]];

  double val = 5;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> datacell = [];
    for(int i = 0; i < data.length; i++)
      datacell.add(Padding(padding: EdgeInsets.symmetric(horizontal: 8), child: Hucre(size, data[i]),));

    return Scaffold(
      backgroundColor: siya,
      body: Column(
        children: [
          Container(
            height: size.height * 0.6, width: size.width * 0.9,
            margin: EdgeInsets.all(20),
            decoration: BoxDecoration(
                color: lacivert,
                borderRadius: BorderRadius.circular(20)
            ),
            child: SingleChildScrollView(scrollDirection: Axis.horizontal, child: Row(children: datacell,))
          ),
          SizedBox(
              width: size.width * 0.8,
              child: Center(
                  child: Slider(
                    min: 0.0,
                    max: 10,
                    divisions: 20,
                    activeColor: siya,
                    value: val,
                    onChanged: (value){
                      setState(() {
                        val = value;
                      });
                    },
                  )
              )
          ),
        ],
      ),
    );
  }

  Stack Hucre(Size size, List<double> data) {
    return Stack(
      children: [
        RotatedBox(quarterTurns: 1, child: Divider(color: aciksiya, height: 20, thickness: 3, indent: 3, endIndent: 3,)),
        Column(
          children: [
            SizedBox(height: (100 - (data[0] > data[1]? data[0] : data[1])) * size.height * 0.006, width: 20),
            Stack(
              children: [
                SizedBox(height: (data[0] - data[1]).abs() * size.height * 0.006, width: 20),
                Positioned(
                  left: 7,
                  child: Container(
                    height: (data[0] - data[1]).abs() * size.height * 0.006, width: 6,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(3), color: data[0] < data[1]? yesi : kirmiz,),
                  )
                ),
                Positioned(
                  top: (data[0] - data[1]).abs() * size.height * 0.0007,
                  child: Container(
                    height: (data[0] - data[1]).abs() * size.height * 0.0046, width: 20,
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: data[0] < data[1]? yesi : kirmiz,),
                  )
                ),
              ],
            ),
            SizedBox(height: (data[0] < data[1]? data[0] : data[1]) * size.height * 0.006, width: 20),
          ],
        ),
      ]
    );
  }
}
