import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'file:///C:/Users/ahmet/AndroidStudioProjects/tourkey_app/lib/Sayfalar/anaSayfa.dart';
import 'package:flutter_app/SingupLogin/TemelSingup.dart';
import 'package:flutter_app/init/profilprovider.dart';
import 'package:flutter_app/init/theme.dart';
import 'package:flutter_app/init/themeprovider.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void>main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  Firebase.initializeApp();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => CostumProfilData(),),
      ChangeNotifierProvider(create: (context) => CostumThemeData(),),
    ],
    child: EasyLocalization(
      supportedLocales: [Locale("tr","TR"), Locale("en","US")], path: 'assets/lang',
      child: Giris(),
    ),
  ));
}

class Giris extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    bool kayit = false;
    Provider.of<CostumThemeData>(context).setThemeData(darktheme);
    return  MaterialApp(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        debugShowCheckedModeBanner: false,
        theme: Provider.of<CostumThemeData>(context).getThemeData,
        darkTheme: darktheme,
        home: kayit ? TemelSayfa() : TemelGiris()
    );
  }
}