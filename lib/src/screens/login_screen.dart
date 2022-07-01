import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ig_clone/src/routes/app_route.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Padding(
          padding: EdgeInsets.fromLTRB(39.0, 0.0, 39.0, 0.0),
          child: LogInForm(),
        ),
      ),
    );
  }
}

class LogInForm extends StatefulWidget {
  const LogInForm({Key? key}) : super(key: key);

  @override
  LogInFormState createState() => LogInFormState();
}

class LogInFormState extends State<LogInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // void saveUser(LoginModel? user, String? token) async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   await prefs.setString(Preferences.user, user!.toJson().toString());
  //   await prefs.setString(Preferences.auth_token, token ?? "");
  // }

  String? email;
  String? password;
  String message = '';

  Future<void> submit(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
                email: email ?? "", password: password ?? "");
        if (credential.user != null) {
          Navigator.pushNamed(context, AppRoute.home);
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'user-not-found') {
          print('No user found for that email.');
          const snackBar =
              SnackBar(content: Text('No user found for that email.'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else if (e.code == 'wrong-password') {
          print('Wrong password provided for that user.');
          const snackBar =
              SnackBar(content: Text('Wrong password provided for that user.'));
          ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
    }
  }

  bool _flagEmail = false, _flagPassword = false;
  // ignore: avoid_init_to_null
  String? messageErrorUserName = null, messageErrorPassword = null;

  bool _obscureText = true;
  // Toggles the password show status
  void _togglePasswordStatus() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(children: [
        SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.only(
                right: 5,
                left: 5,
                top: MediaQuery.of(context).size.height * 0.3),
            child: Form(
              key: _formKey,
              child: Column(children: [
                TextFormField(
                  decoration: InputDecoration(
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
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
                    fillColor: Colors.grey.shade100,
                    filled: true,
                    hintText: 'Password',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty || value.length < 4) {
                      return "Mật khẩu quá ngắn !";
                    } else {
                      password = value.trim();
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
                      'Sign In',
                      style: TextStyle(
                        color: Color(0xff4c505b),
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
                          // Navigator.pushNamed(context, AppRoute.home);
                          submit(context);
                        },
                        icon: const Icon(Icons.arrow_forward),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.pushNamed(context, AppRoute.register);
                        },
                        child: const Text(
                          'Register',
                          style: TextStyle(
                            decoration: TextDecoration.underline,
                            fontSize: 18,
                            color: Color(0xff4c505b),
                          ),
                        ),
                      ),
                      // TextButton(
                      //   onPressed: () {},
                      //   child: const Text(
                      //     'Forgot Password',
                      //     style: TextStyle(
                      //       decoration: TextDecoration.underline,
                      //       fontSize: 18,
                      //       color: Color(0xff4c505b),
                      //     ),
                      //   ),
                      // ),
                    ]),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
