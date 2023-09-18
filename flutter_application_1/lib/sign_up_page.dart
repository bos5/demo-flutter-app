import 'package:flutter/material.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        width: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
            ],
          ),
        ),
        child: Column(children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Image.asset(
              "images/doctors.png",
              scale: 2.5,
              // height: 300,
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            alignment: Alignment.centerLeft,
            child: const Text(
              'Sign up',
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              textAlign: TextAlign.left,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5),
            child: Column(
              children: [
                Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    child: TextField(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        hintText: 'Enter your username',
                        hintStyle: TextStyle(color: Colors.grey[400]),
                      ),
                    )),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
