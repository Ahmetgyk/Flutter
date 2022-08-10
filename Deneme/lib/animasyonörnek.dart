import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Color siya = Color(0xff222831);
Color beyaz = Color(0xffE8E8E8);
Color koyugri = Color(0xff333333);
Color gr = Color(0xffDDDDDD);
Color aciksiya = Color(0xff333533);
Color gir = Color(0xffD6D6D6);
Color kirmiz = Color(0xff990100);
Color yesi = Color(0xffC6DE41);
Color lacivert = Color(0xff30475E);
Color sar = Color(0xffFCA311);

class Animasyon extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: animasyon(),
      debugShowCheckedModeBanner: false,
    );
  }
}
class animasyon extends StatefulWidget {
  @override
  _animasyonState createState() => _animasyonState();
}

class _animasyonState extends State<animasyon> with SingleTickerProviderStateMixin {

  bool isanim = false;
  bool login = false;
  AnimationController _controller;
  Animation<double> _dbanim;
  Animation _curve;

  final isimcon = TextEditingController();
  final emailcon = TextEditingController();
  final parolacon = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: Duration(milliseconds: 700), vsync: this);

    _curve = CurvedAnimation(parent: _controller, curve: Curves.slowMiddle);

    _dbanim = TweenSequence(
      <TweenSequenceItem<double>>[
        TweenSequenceItem<double>(tween: Tween<double>(begin: 0, end: 8), weight: 8),
        TweenSequenceItem<double>(tween: Tween<double>(begin: 8, end: 3.5), weight: 8),
      ]
    ).animate(_curve);

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed) setState(() {isanim = true;});
      if(status == AnimationStatus.dismissed) setState(() {isanim = false;});
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        overflow: Overflow.visible,
        children: [
          Container(
            height: size.height, width: size.width,
            color: siya,
          ),
          Container(
            height: size.height * 0.7, width: size.width,
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: lacivert,
              borderRadius: BorderRadius.circular(20),
              image: DecorationImage(image: AssetImage("assets/passport.png"), fit: BoxFit.fitWidth),
            ),
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, _){
              return Positioned(
                bottom: size.height * (0.08 - _dbanim.value * 0.01), left: size.width * (0.1 - _dbanim.value * 0.0125),
                child: Container(
                  height: size.height * (0.12 + _dbanim.value * 0.11), width: size.width * (0.8 + _dbanim.value * 0.025),
                  decoration: BoxDecoration(
                      color: sar,
                      borderRadius: BorderRadius.circular(20)
                  ),
                  child: _dbanim.value == 0? row(size) : _dbanim.value >= 3.2? login? Login(size): Signup(size) : Container(),
                ),
              );
            }
          ),
          AnimatedBuilder(
            animation: _controller,
            builder: (BuildContext context, _){
              return Positioned(
                bottom: size.height * (0.18 + _dbanim.value * 0.1), left: size.width * 0.5 - 70,
                child: CircleAvatar(
                  radius: 70,
                  backgroundColor: kirmiz,
                  child: isanim? Icon(Icons.account_circle, size: 140, color: koyugri.withOpacity(0.8)) :
                    Image.asset('assets/logo.png', fit: BoxFit.cover,),
                ),
              );
            }
          ),
          Positioned(
            top: 30, left: 30,
            child: isanim? GestureDetector(
              child: CircleAvatar(
                  radius: 30,
                  backgroundColor: yesi.withOpacity(0.8),
                  child: Icon(Icons.arrow_back, size: 50, color: koyugri.withOpacity(0.8))
              ),
              onTap: (){_controller.reverse();},
            ) : Container(),
          )
        ],
      )
    );
  }

  Column Login(Size size) {
    return Column(
      children: [
        Spacer(),
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
        SizedBox(height: 15,),
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
        SizedBox(height: 15,),
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
        ),
        Spacer(),
      ],
    );
  }
  Column Signup(Size size) {
    return Column(
      children: [
        Spacer(),
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
        SizedBox(height: 15,),
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
        ),
        Spacer(),
      ],
    );
  }
  Row row(Size size) {
    return Row(
      children: [
        Spacer(),
        GestureDetector(
          child: Container(
            height: size.height * 0.1, width: size.width * 0.35,
            child: Center(child: Text("Login", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),),
          ),
          onTap: (){_controller.forward(); login = true;},
        ),
        Spacer(),
        RotatedBox(quarterTurns: 1,
          child: Divider(color: aciksiya, height: 20, thickness: 3, indent: 10, endIndent: 10,),),
        Spacer(),
        GestureDetector(
          child: Container(
            height: size.height * 0.1, width: size.width * 0.35,
            child: Center(child: Text("Signup", style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),),),
          ),
          onTap: (){_controller.forward(); login = false;},
        ),
        Spacer(),
      ],
    );
  }
}