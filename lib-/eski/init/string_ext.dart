import 'package:easy_localization/easy_localization.dart';

extension Stringlocalization on String{
  String get locale =>this.tr();
}