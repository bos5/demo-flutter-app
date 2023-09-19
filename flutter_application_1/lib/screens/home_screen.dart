import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/login_page.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const MyLoginPage()));
              },
              child: const Text('Log out')),
        ],
      ),
    );
  }
}
