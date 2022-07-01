import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ig_clone/src/routes/app_route.dart';
import 'package:logger/logger.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final formKey = GlobalKey<FormState>();
  String? email;
  String? password;

  Future<void> submit() async {
    if (formKey.currentState!.validate()) {
      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email ?? "",
          password: password ?? "",
        );
        if (credential.user != null) {
          Logger().d(credential.user.toString());
          Navigator.pushNamed(context, AppRoute.login);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'weak-password') {
          print('The password provided is too weak.');
        } else if (e.code == 'email-already-in-use') {
          print('The account already exists for that email.');
        }
      } catch (e) {
        print(e);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      // ),
      backgroundColor: Colors.white,
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                right: 20,
                left: 20,
                top: MediaQuery.of(context).size.height * 0.2),
            child: Form(
              key: formKey,
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Email',
                  ),
                  validator: (value) {
                    if (value!.isEmpty ||
                        !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value.trim())) {
                      return "Email không đúng !";
                    } else {
                      email = value.trim();
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    hintText: 'Password',
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return "Mật khẩu quá ngắn !";
                    } else {
                      password = value;
                      return null;
                    }
                  },
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Register',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 27,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                      CircleAvatar(
                        radius: 30,
                        backgroundColor: const Color(0xff4c505b),
                        child: IconButton(
                          color: Colors.white,
                          onPressed: () {
                            submit();
                          },
                          icon: const Icon(Icons.arrow_forward),
                        ),
                      ),
                    ]),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoute.login);
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ]),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
