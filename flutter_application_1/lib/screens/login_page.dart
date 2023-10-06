import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_option.dart';
import 'package:flutter_application_1/screens/sign_up_page.dart';
import 'package:flutter_application_1/utils/validate.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:flutter_application_1/packages/authentication_service/lib/authentication_service.dart';

class MyLoginPage extends StatefulWidget {
  const MyLoginPage({Key? key}) : super(key: key);
  @override
  State<MyLoginPage> createState() => _MyLoginPageState();
}

class _MyLoginPageState extends State<MyLoginPage> {
  bool emailValid = false;
  @override
  Widget build(BuildContext context) {
    var emailContrl = TextEditingController();
    var passwordContrl = TextEditingController();

    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: <Widget>[
            const SizedBox(
              height: 50,
            ),
            const Text(
              'Sign in',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(children: <Widget>[
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'username',
                    style: TextStyle(fontSize: 20),
                    // set this to left of screen
                  ),
                ),
              ]),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      // decoration: const BoxDecoration(
                      //   color: Colors.white,
                      //   borderRadius: BorderRadius.all(Radius.circular(10)),
                      // ),
                      child: TextField(
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.person),
                          hintText: 'Enter your username',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                          errorText: emailValid ? 'Invalid username' : null,
                        ),
                        onSubmitted: (value) {
                          setState(() {
                            emailValid = !validateEmail(value);
                          });
                        },
                        controller: emailContrl,
                      ),
                    )
                  ],
                )),
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  alignment: Alignment.centerLeft,
                  child: const Text(
                    'password',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ]),
            ),
            Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      alignment: Alignment.centerLeft,
                      child: TextField(
                        obscureText: true,
                        decoration: InputDecoration(
                          prefixIcon: const Icon(Icons.lock),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Colors.grey[400]),
                        ),
                        controller: passwordContrl,
                      ),
                    ),
                  ],
                )),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              alignment: Alignment.bottomRight,
              child: TextButton(
                onPressed: () {},
                child: const Text('Forgot password?',
                    style: TextStyle(fontSize: 15, color: Colors.black)),
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  if (emailContrl.text.isEmpty || passwordContrl.text.isEmpty) {
                    return;
                  } else {
                    // loginWithEmail(context, emailContrl, passwordContrl);
                    context
                        .read<AuthenticationService>()
                        .loginWithEmailAndPassword(
                            email: emailContrl.text,
                            password: passwordContrl.text);
                  }
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 216, 36, 126),
                  // foregroundColor: const Color(0xFFE94057),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: const Text(
                  'Log in',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(top: 10, bottom: 0),
              alignment: Alignment.center,
              child: Text('Or sign in with',
                  style: TextStyle(fontSize: 15, color: Colors.grey[400])),
            ),
            const LoginOption(),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              alignment: Alignment.center,
              child: Text('Or sign in with',
                  style: TextStyle(fontSize: 15, color: Colors.grey[400])),
            ),
            Container(
              padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 20),
              alignment: Alignment.center,
              child: TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const MySignUpPage()));
                },
                child: const Text('Sign up',
                    style: TextStyle(fontSize: 20, color: Colors.black)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
