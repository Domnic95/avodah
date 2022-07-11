import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_badger/flutter_app_badger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:southwind/UI/theme/apptheme.dart';
import 'package:southwind/constant/Global.dart';
import 'package:southwind/routes/routes.dart';
import 'package:southwind/utils/helpers.dart';
import 'package:southwind/utils/utilsContstant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await runZonedGuarded(
    () async {
      await Firebase.initializeApp();
      WidgetsFlutterBinding.ensureInitialized();
      sharedPreferences = await SharedPreferences.getInstance();
      if(!(Utils.getBool(key_keep_me_logged_in) ?? false)){
        Utils.removePref();
      }
      FlutterAppBadger.removeBadge();
      SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          // systemNavigationBarColor: Colors.white, // navigation bar color
          statusBarColor: Colors.white,
          statusBarBrightness: Brightness.dark, // status bar color
          statusBarIconBrightness: Brightness.dark));
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      runApp(ProviderScope(child: MyApp()));
    },
    (error, st) => print(error),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Avodah',
      theme: ThemeData(
        brightness: Brightness.light,
        // scaffoldBackgroundColor: primarySwatch[50],
        // fontFamily: 'Poppins',
        appBarTheme: AppBarTheme(
            // color: primarySwatch[900]!,
            backgroundColor: Colors.white,
            titleTextStyle: TextStyle(color: primarySwatch[900]),
            // textTheme: Theme.of(context).textTheme,
            foregroundColor: primarySwatch[900],
            iconTheme: IconThemeData(color: primarySwatch[900])),
        textTheme: GoogleFonts.poppinsTextTheme(TextTheme(
            bodyText1: TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 18,
                color: primarySwatch[900]),
            bodyText2: TextStyle(
                fontWeight: FontWeight.w400,
                fontSize: 16,
                color: primarySwatch[900]))),
        // iconTheme: IconThemeData(color: primarySwatch[700]),
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: generateMaterialColor(primaryColor),
      ),
      onGenerateRoute: Routes.onRouteGenerate,
      initialRoute: Routes.splashScreen,
    );
  }
}
