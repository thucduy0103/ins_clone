import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../routes/app_route.dart';

class PageViewUser extends StatefulWidget {
  const PageViewUser({Key? key}) : super(key: key);

  @override
  _PageViewUserState createState() => _PageViewUserState();
}

class _PageViewUserState extends State<PageViewUser> {
  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    Navigator.pushNamed(context, AppRoute.login);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        child: Center(
          child: ElevatedButton(
              onPressed: () => {signOut()}, child: const Text("Đăng xuất")),
        ));
  }
}
