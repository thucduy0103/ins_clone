import 'package:flutter/material.dart';

import '../screens/home_screen.dart';
import '../screens/image_picker_screen.dart';
import '../screens/login_screen.dart';
import '../screens/register_screen.dart';
import '../screens/splash_screen.dart';

class AppRoute {
  static const home = '/home';
  static const login = '/login';
  static const register = '/register';
  static const root = '/';
  static const pickerImage = '/picker_image';
  static const requestLivestream = '/request_livestream';
  static const livestream = '/livestream';
  static const changeInformation = '/change_information';
  static const changePassword = '/change_password';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case root:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case home:
        return MaterialPageRoute(builder: (_) => const HomeScreen());
      case login:
        return MaterialPageRoute(builder: (_) => const LoginScreen());
      case register:
        return MaterialPageRoute(builder: (_) => const RegisterScreen());
      case pickerImage:
        return MaterialPageRoute(builder: (_) => const ImagePickerScreen());
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
