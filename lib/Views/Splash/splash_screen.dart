import 'dart:async';

import 'package:easy_localization/easy_localization.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';

import '../Categories/subcategories/register_subcategories.dart';
import '../Dashboard/dashboard.dart';
import '../Login/login.dart';
import '../Register/register_form.dart';
import '../Welcome/welcome_screen.dart';

// Future<void> backgroundHandler(RemoteMessage message) async {
//   print(message.data.toString());
//   print(message.notification!.title);
// }
Future<void> backgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);

  // LocalNotificationService.createanddisplaynotification(message);
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(backgroundHandler);

  // LocalNotificationService.initialize();

  runApp(EasyLocalization(
    child: MyApp(),
    supportedLocales: [Locale('en', 'US'), Locale('ar', 'AE')],
    path: 'assets/translations',
    saveLocale: true,
    fallbackLocale: Locale('en', 'US'),
  ));
}

var isLoggedin = false;

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();

// static void setLocale(BuildContext context, Locale newLocale) {
//   _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
//   state?.setLocale(newLocale);
// }
}

class _MyAppState extends State<MyApp> {
  // Locale? _locale;
  //
  // setLocale(Locale locale) {
  //   setState(() {
  //     _locale = locale;
  //   });
  // }

  // @override
  // void didChangeDependencies() {
  //   getLocale().then((locale) => {setLocale(locale)});
  //   super.didChangeDependencies();
  // }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Bina',
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      // localizationsDelegates: AppLocalizations.localizationsDelegates,
      // supportedLocales: AppLocalizations.supportedLocales,
      // locale: _locale,

      initialRoute: '/',
      routes: {
        // When navigating to the "/" route, build the FirstScreen widget.
        // When navigating to the "/second" route, build the SecondScreen widget.
        '/registerRoute': (context) => RegisterForm(),
        '/subcategoryRoute': (context) => RegisterSubCategoryPage(),
      },
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Montserrat',
      ),
      home: const SplashScreen(),
      // builder: EasyLoading.init(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    getSharedPreferences();
  }

  getSharedPreferences() async {
    SharedPreferences myPref = await SharedPreferences.getInstance();

    if (myPref.getBool("isLoggedin") != null) {
      if (myPref.getBool('isLoggedin') == true) {
        Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (context) => Dashboard(
                          userData: '',
                        ))));
      } else {
        Timer(
            const Duration(seconds: 3),
            () => Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (context) => const Login())));
      }
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Welcome())));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/images/splash.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Stack(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          children: const [
            Padding(
              padding: EdgeInsets.symmetric(vertical: 18.0),
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Text('Powered By Bina',
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
