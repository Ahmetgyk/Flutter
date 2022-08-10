import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_app/init/string_ext.dart';
import 'package:flutter/material.dart';

class LocalText extends StatelessWidget{
  final String text;

  const LocalText({Key key, @required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AutoSizeText(text.locale, style: TextStyle(fontSize: 30),);
  }
}