import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/init/theme.dart';
import 'package:intl/intl.dart';
import 'package:flutter_app/utils.dart';

class LogInPage extends StatefulWidget {
  @override
  _LogInPageState createState() => _LogInPageState();
}
class _LogInPageState extends State<LogInPage> {
  final emailcon = TextEditingController();
  final parolacon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = MediaQuery.of(context).size.width;
    double h = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          width: w, height: h, color: Color(0xff30475E),
          child: Column(
            children: [
              Spacer(flex: 2,),
              Container(height: h * 0.2, child: Image.asset('assets/icons/logo.png', fit: BoxFit.fitHeight)),
              Spacer(flex: 1,),
              Column(
                children: [
                  EmailContainer(w, h, emailcon),
                  PasswordContainer(w, h, parolacon),
                  GestureDetector(
                      child: LoginContainer(h, w),
                      onTap: (){}
                  ),
                ],
              ),
              Spacer(flex: 2,),
            ],
          ),
        ),
      ),
    );
  }

  Container LoginContainer(double h, double w) {
    return Container(
        height: h * 0.07,
        width: w * 0.8,
        decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(20)), color: Color(0xffbC6DE41)) ,
        child: Center(
          child: Text('LOGIN', style: TextStyle(fontSize: 30, color: Color(0xffb333533))),
        ));
  }
  Container PasswordContainer(double w, double h, TextEditingController parolacon) {
    return Container(
      width: w, height: h * 0.1,
      margin: EdgeInsets.all(10),
      child: TextFormField(
        validator: (name){if(name.isEmpty){return 'please enter your password';}},
        controller: parolacon,
        decoration: InputDecoration(
            fillColor: Color(0xffbC0C0C0),
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
    );
  }
  Container EmailContainer(double w, double h, TextEditingController emailcon) {
    return Container(
      width: w, height: h * 0.1,
      margin: EdgeInsets.all(10),
      child: TextFormField(
        validator: (email) {
          if (email.isEmpty) {
            return 'please enter your email';
          }
        },
        controller: emailcon,
        decoration: InputDecoration(
            fillColor: Color(0xffbC0C0C0),
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
    );
  }
}
