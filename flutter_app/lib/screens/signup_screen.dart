import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluiter_app/screens/home_screen.dart';
import 'package:fluiter_app/screens/signin_screen.dart';
import 'package:fluiter_app/utils/error_dialog.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _retypepasswordTextController =
      TextEditingController();
  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Create Account",
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
              20,
              MediaQuery.of(context).size.height * 0.15,
              20,
              0,
            ),
            child: Column(
              children: [
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: const Text('Username'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0.0, 16, 20),
                  child: Opacity(
                    opacity: 0.5,
                    child: TextField(
                      controller: _emailTextController,
                      decoration: const InputDecoration(
                        labelText: 'Type your username',
                        prefixIcon: Icon(Icons.person),
                      ),
                    ),
                  ),
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: const Text('Password'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0.0, 16, 0),
                  child: Opacity(
                    opacity: 0.5,
                    child: TextField(
                      controller: _passwordTextController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Type your password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: AlignmentDirectional.bottomStart,
                  padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: const Text('Password'),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0.0, 16, 0),
                  child: Opacity(
                    opacity: 0.5,
                    child: TextField(
                      controller: _retypepasswordTextController,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'Confirm your password',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                ElevatedButton(
                  onPressed: () {
                    _onSignUpClick();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Center(
                    child: Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 185,
                ),
                const Text("Already have account?"),
                TextButton(
                  child: const Text(
                    "SIGN IN",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignInScreen(),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _onSignUpClick() async {
    try {
      if (_passwordTextController.text == _retypepasswordTextController.text) {
        await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
                email: _emailTextController.text,
                password: _passwordTextController.text)
            .then(
              (value) => {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const HomeScreen(),
                  ),
                ),
              },
            );
        showErrorDialog(context, "Password not match");
      }
    } on FirebaseAuthException catch (e) {
      await showErrorDialog(context, "${e.code}");
    }
  }
}
