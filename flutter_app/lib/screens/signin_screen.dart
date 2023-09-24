import 'package:firebase_auth/firebase_auth.dart';
import 'package:fluiter_app/screens/home_screen.dart';
import 'package:fluiter_app/screens/reset_password.dart';
import 'package:fluiter_app/screens/signup_screen.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final TextEditingController _passwordTextController = TextEditingController();

  final TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(
                20, MediaQuery.of(context).size.height * 0.05, 20, 0),
            child: Column(
              children: [
                const Text(
                  "Login",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 50,
                ),
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
                Container(
                  alignment: Alignment.bottomRight,
                  child: TextButton(
                    child: const Text(
                      "Forgot password?",
                      style: TextStyle(color: Colors.grey),
                    ),
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ResetPasswordScreen(),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    _onLoginClick();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                  ),
                  child: const Center(
                    child: Text(
                      'LOGIN',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                const SizedBox(
                  height: 40,
                ),
                const Text("Or Sign Up Using"),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.facebook,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        FontAwesomeIcons.twitter,
                        size: 40,
                        color: Colors.blue,
                      ),
                    ),
                    IconButton(
                      onPressed: (){},
                      icon: const Icon(
                        FontAwesomeIcons.google,
                        size: 40,
                        color: Colors.red,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 125,
                ),
                const Text("Have not account yet?"),
                TextButton(
                  child: const Text(
                    "SIGN UP",
                    style: TextStyle(color: Colors.black),
                  ),
                  onPressed: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SignUpScreen(),
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

  void _onLoginClick() {
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: _emailTextController.text,
            password: _passwordTextController.text)
        .then((value) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const HomeScreen(),
        ),
      );
    });
  }
}
