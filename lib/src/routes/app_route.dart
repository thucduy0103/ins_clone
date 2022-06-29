import 'package:flutter/material.dart';

import '../screens/splash_screen.dart';

class AppRoute {
  static const home = '/home';
  static const login = '/login';
  static const root = '/';
  static const settingLivestream = '/setting_livestream';
  static const requestLivestream = '/request_livestream';
  static const livestream = '/livestream';
  static const changeInformation = '/change_information';
  static const changePassword = '/change_password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      // case home:
      //   return MaterialPageRoute(builder: (_) => const HomeScreen());
      // case login:
      //   return MaterialPageRoute(builder: (_) => const LoginScreen());
      // case settingLivestream:
      //   return MaterialPageRoute(
      //       builder: (_) => const SettingLiveStreamScreen(),
      //       settings: RouteSettings(arguments: settings.arguments));
      // case requestLivestream:
      //   return MaterialPageRoute(
      //       builder: (_) => RequestLiveStreamScreen(),
      //       settings: RouteSettings(arguments: settings.arguments));
      // case livestream:
      //   return MaterialPageRoute(
      //       builder: (_) => const LivestreamScreen(),
      //       settings: RouteSettings(arguments: settings.arguments));
      // case changeInformation:
      //   return MaterialPageRoute(
      //       builder: (_) => const ChangeInformationScreen());
      // case changePassword:
      //   return MaterialPageRoute(builder: (_) => const ChangePasswordScreen());
      default:
        return MaterialPageRoute(
            builder: (_) => Scaffold(
                  body: Center(
                      child: Text('No route defined for ${settings.name}')),
                ));
    }
  }
}
