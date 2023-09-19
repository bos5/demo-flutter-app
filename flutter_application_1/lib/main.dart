import 'package:flutter_application_1/src/blocs/auth_bloc.dart';

import 'src/app.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'src/resources/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(
    MyApp(
      AuthBloc(),
      MaterialApp(
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: MyLoginPage(),
        debugShowCheckedModeBanner: false,
      ),
    ),
  );
}
