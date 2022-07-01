import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../routes/app_route.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    startTimer();
  }

  @override
  Widget build(BuildContext context) {
    return const Material(
      // child: Center(child: AppIconWidget(image: Assets.appLogo)),
      child: Center(child: Text("INSTAGRAM CLONE")),
    );
  }

  startTimer() {
    var _duration = const Duration(milliseconds: 1000);
    return Timer(_duration, navigate);
  }

  navigate() async {
    // SharedPreferences preferences = await SharedPreferences.getInstance();

    // if (preferences.getBool(Preferences.is_logged_in) ?? false) {
    //   Navigator.of(context).pushReplacementNamed(AppRoute.home);
    // } else {
    //   Navigator.of(context).pushReplacementNamed(AppRoute.login);
    // }

    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user != null) {
        // print(user.uid);
        Navigator.pushNamed(context, AppRoute.home);
      } else {
        Navigator.of(context).pushReplacementNamed(AppRoute.login);
      }
    });
  }
}
