import 'package:attendie/src/pages/global.dart';
import 'package:attendie/src/pages/home.dart';
import 'package:attendie/src/splash.dart';
import 'package:flutter/material.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: sharedPreferences.getBool('isLoggedIn') != null
          ? const HomePage()
          : const SplashScreen(),
    );
  }
}


