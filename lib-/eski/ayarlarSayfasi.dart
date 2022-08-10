import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: contactPage(),
    );
  }
}

class contactPage extends StatefulWidget {
  @override
  _State createState() => _State();
}

class _State extends State<contactPage> {
  Color siyah = Color(0xffb202020);
  Color aciksiyah = Color(0xffb333533);
  Color gri = Color(0xffbD6D6D6);
  Color aciksari = Color(0xffbFFEE32);
  Color sari = Color(0xffbFFD100);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: siyah,
      body: Stack(
         children: [
           Container(
             width: size.width, height: size.height,
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   cell(adres: 'Facebook adresi', renk: siyah, renk2: gri, size: size, icon: Icons.contactless,),
                   cell(adres: 'Twitter adresi', renk: siyah, renk2: gri, size: size, icon: Icons.contactless,),
                   cell(adres: 'Instagram adresi', renk: siyah, renk2: gri, size: size, icon: Icons.contactless,),
                   cell(adres: 'Email adresi', renk: siyah, renk2: gri, size: size, icon: Icons.contactless,),
                 ],
               ),
             ),
           ),
           Positioned(top: 0,
             child: Container(
               height: size.height * 0.3, width: size.width,
               decoration: BoxDecoration(
                   color: aciksari,
                   borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
               ),
               child: Center(child: Text('Bizimle iletişime geçin', style: TextStyle(fontSize: 30),),),
             ),
           )
         ],
      ),
    );
  }
}
class cell extends StatelessWidget {
  String adres;
  IconData icon;
  Size size;
  Color renk;
  Color renk2;

  cell({this.adres, this.icon, this.size, this.renk, this.renk2});
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100, width: size.width * 0.9,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: renk2,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: renk2, width: 3)
      ),
      child: Row(
        children: [
          Container(
            width: 80 ,height: 100,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: renk,
                borderRadius: BorderRadius.circular(20),
            ),
            child: Center(child: Icon(icon, size: 30, color: Color(0xffbFFEE32),),),
          ),
          SizedBox(width: 10,),
          SelectableText(adres, style: TextStyle(fontSize: 30), toolbarOptions: ToolbarOptions(copy: true),)
        ],
      ),
    );
  }
}
