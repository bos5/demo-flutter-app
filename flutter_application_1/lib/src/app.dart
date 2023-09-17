import 'package:flutter/material.dart';
import 'resources/login_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyLoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}
