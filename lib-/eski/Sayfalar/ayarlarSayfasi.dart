import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_app/init/local_keys.g.dart';
import 'package:flutter_app/init/string_ext.dart';
import 'package:flutter_app/init/theme.dart';

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
  bool dark = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: (){Navigator.pop(context);},
        ),
      ),
      backgroundColor: theme().renk(theme().Siyah, dark),
      body: Stack(
         children: [
           Container(
             width: size.width, height: size.height,
             child: Center(
               child: Column(
                 mainAxisAlignment: MainAxisAlignment.end,
                 children: [
                   cell(adres: 'Facebook adresi', renk: theme().renk(theme().Siyah, dark),
                     renk2: theme().renk(theme().Gri, dark), size: size,
                     icon: 'assets/images/facebook.jpg', url: 'https://www.google.com.tr', dark: dark,),
                   cell(adres: 'Twitter adresi',  renk: theme().renk(theme().Siyah, dark),
                     renk2: theme().renk(theme().Gri, dark), size: size,
                     icon: 'assets/images/twitter.jpg', url: 'https://www.google.com.tr', dark: dark,),
                   cell(adres: 'Instagram adresi', renk: theme().renk(theme().Siyah, dark),
                     renk2: theme().renk(theme().Gri, dark), size: size,
                     icon: 'assets/images/instagram.jpg', url: 'https://www.google.com.tr', dark: dark,),
                   cell(adres: 'Email adresi', renk: theme().renk(theme().Siyah, dark),
                     renk2: theme().renk(theme().Gri, dark), size: size,
                     icon: 'assets/images/gmail.png', url: 'http://flutter.dev', dark: dark,),
                 ],
               ),
             ),
           ),
           Positioned(top: 0,
             child: Container(
               height: size.height * 0.3, width: size.width,
               decoration: BoxDecoration(
                   color: theme().renk(theme().Sari, dark),
                   borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
               ),
               child: Center(child: Text(localKeys.iletisimSayfasi_baslik.locale, style: TextStyle(fontSize: 30),),),
             ),
           )
         ],
      ),
    );
  }
}
class cell extends StatelessWidget {
  String url;
  String adres;
  String icon;
  Size size;
  Color renk;
  Color renk2;
  bool dark;

  cell({this.url, this.adres, this.icon, this.size, this.renk, this.renk2, this.dark});
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
            child: Center(child: GestureDetector(
              child: Container(
                width: 70, height: 70,
                decoration: BoxDecoration(
                  image: DecorationImage(image: AssetImage(icon), fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(20)
                ),
              ),
              onTap: (){Utils._launchUrl(url);},
            ),),
          ),
          SizedBox(width: 10,),
          SelectableText(adres, style:
          TextStyle(fontSize: 30, color: theme().renk(theme().Siyah, dark)), toolbarOptions: ToolbarOptions(copy: true),)
        ],
      ),
    );
  }
}
class Utils{
  static Future openLink({@required String url}) => _launchUrl(url);

  static Future _launchUrl(String url) async {
    if(await canLaunch(url)){
      await launch(url);
    }
  }
}
