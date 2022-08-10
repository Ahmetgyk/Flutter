import 'package:flutter/material.dart';

Color lacivert = Color(0xff30475E);
Color koyugri = Color(0xff333333);

class SingupLogin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginSingup(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class LoginSingup extends StatefulWidget {
  @override
  _LoginSingupState createState() => _LoginSingupState();
}
class _LoginSingupState extends State<LoginSingup> {
  int _page = 0;

  final isimcon = TextEditingController();
  final emailcon = TextEditingController();
  final parolacon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Widget> sayfaicon = [];
    for(int i = 0; i < 3; i++){
      if(i == _page) sayfaicon.add(Padding(
          padding: const EdgeInsets.all(3.0),
          child: Container(width: 30, height: 13,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(6) ,color: Color(0xffD6D6D6)),
          )
      ));
      else sayfaicon.add(Padding(
        padding: const EdgeInsets.all(3.0),
        child: Icon(Icons.brightness_1_outlined, size: 15, color: Color(0xffD6D6D6),),
      ));
    }

    return Scaffold(
        body: Column(
          children: [
            Expanded(flex: 5, child: UstWidget(size.width, size.height, sayfaicon),),
            Expanded(flex: 2, child: AltWidget(size, context),)
          ],
        )
    );
  }

  Container AltWidget(Size size, BuildContext context) {
    return Container(
      color: Color(0xff30475E),
      child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Spacer(flex: 2,),
              GestureDetector(
                child: Container(
                    height: size.height * 0.07, width: size.width * 0.8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xffbC6DE41)) ,
                    child: Center(
                      child: Text("signup", style: TextStyle(fontSize: 30, color: Color(0xffb333533), fontWeight: FontWeight.w600)),
                    )
                ),
                onTap: (){
                  showModalBottomSheet(
                    context: context, builder: (context) => bottomsheet(size, isimcon, emailcon, parolacon),
                    backgroundColor: lacivert,
                    isScrollControlled: true,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.vertical(top: Radius.circular(20))
                    )
                  );
                },
              ),
              Spacer(flex: 1,),
              GestureDetector(
                child: Container(
                    height: size.height * 0.07, width: size.width * 0.8,
                    decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xffFCA311)) ,
                    child: Center(
                      child: Text("login", style: TextStyle(fontSize: 30, color: Color(0xffb333533), fontWeight: FontWeight.w600)),
                    )
                ),
                onTap: (){},
              ),
              Spacer(flex: 2,),
            ],
          )
      ),
    );
  }
  Container UstWidget(double w, double h, List<Widget> sayfaicon,) {
    return Container(
      color: Color(0xff222831),
      child: Stack(
        children: [
          Container(
            width: w, height: h * 5/7,
            child: PageView(
              scrollDirection: Axis.horizontal,
              children: [
                IconWidget(w: w, h: h * 5/7,
                  widget: Container(height: w * 0.5, width: w * 0.5,
                    child: Image.asset('assets/questionnaire.png', fit: BoxFit.cover,),),
                  yazi: 'Soruları cevapla',),
                IconWidget(w: w, h: h * 5/7,
                  widget: Container(height: w * 0.5, width: w * 0.5,
                    child: Image.asset('assets/navigator.png', fit: BoxFit.cover,),),
                  yazi: 'Planını oluştur',),
                IconWidget(w: w, h: h * 5/7,
                    widget: CircleAvatar(radius: 100, backgroundColor: Color(0xffcea105),
                        child: Image.asset('assets/passport.png', fit: BoxFit.cover,)),
                    yazi: 'Tatilin keyfini çıkart'),
              ],
              onPageChanged: (value) {setState(() {_page = value;});},
            ),
          ),
          Positioned(
            bottom: 10, child: Container(
            width: w,
            child: Center(
                child: Row(mainAxisAlignment: MainAxisAlignment.center, children: sayfaicon,)
            ),
          ),
          )
        ],
      ),
    );
  }
}
Widget bottomsheet(Size size, TextEditingController isimcon, TextEditingController emailcon, TextEditingController parolacon){
  return Stack(
    overflow: Overflow.visible,
    children: [
      SingleChildScrollView(
        child: Container(
          height: size.height * 0.47,
          margin: EdgeInsets.all(20),
          child:  Column(
            children: [
              SizedBox(height: 40,),
              Container(
                width: size.width * 0.9, height: size.height * 0.13,
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (name){if(name.isEmpty){return 'please enter your user name';}},
                  controller: isimcon,
                  maxLength: 20,
                  decoration: InputDecoration(
                      fillColor: lacivert,
                      filled: true,
                      labelText: 'User Name',
                      prefixIcon: Icon(Icons.account_circle),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
                      suffixIcon: isimcon.text.isEmpty ? Container(width: 0) : IconButton(icon: Icon(Icons.close), onPressed: () => isimcon.clear())
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Container(
                width: size.width * 0.9, height: size.height * 0.1,
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (email) {
                    if (email.isEmpty) return 'please enter your email';
                    //if (!EmailValidator.validate(email)) return 'please enter in correct format';
                  },
                  controller: emailcon,
                  decoration: InputDecoration(
                      fillColor: lacivert,
                      filled: true,
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email_outlined),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
                      suffixIcon: emailcon.text.isEmpty
                          ? Container(width: 0)
                          : IconButton(
                          icon: Icon(Icons.close), onPressed: () => emailcon.clear())
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.done,
                ),
              ),
              Container(
                width: size.width * 0.9, height: size.height * 0.1,
                margin: EdgeInsets.all(10),
                child: TextFormField(
                  validator: (name){
                    if(name.isEmpty){return 'please enter your password';}
                    if(name.length < 6){return 'password must be greater than six syllables';}
                  },
                  controller: parolacon,
                  decoration: InputDecoration(
                      fillColor: lacivert,
                      filled: true,
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.vpn_key),
                      enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
                      focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16), borderSide: BorderSide(color: Color(0xff222831), width: 4)),
                      suffixIcon: parolacon.text.isEmpty ? Container(width: 0) : IconButton(icon: Icon(Icons.close),
                          onPressed: () => parolacon.clear())
                  ),
                  keyboardType: TextInputType.name,
                  textInputAction: TextInputAction.done,
                ),
              )
            ],
          ),
        ),
      ),
      Positioned(
        top: -90, left: size.width * 0.5 - 70,
        child: CircleAvatar(
          radius: 70, backgroundColor: Colors.red,
          child: Icon(Icons.account_circle, size: 140, color: koyugri.withOpacity(0.6),),
        ),
      )
    ]
  );
}
class IconWidget extends StatelessWidget {
  Widget widget;
  String yazi;
  double w;
  double h;

  IconWidget({this.widget, this.yazi, this.w, this.h});
  @override
  Widget build(BuildContext context) {
    return Container(width: w, height: h * 5/7,
      child: Center(child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          widget,
          SizedBox(height: 10,),
          Text(yazi, style: TextStyle(fontSize: 40, color: Color(0xffD6D6D6)),)
        ],
      ),),
    );
  }
}