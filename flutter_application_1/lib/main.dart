import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/firebase_activity/firebase_login_signup.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:provider/provider.dart';
import 'firebase_activity/firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// ...

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  if (kIsWeb) {
    // initialiaze the facebook javascript SDK
    await FacebookAuth.i.webAndDesktopInitialize(
      appId: "876416693343858",
      cookie: true,
      xfbml: true,
      version: "v8.9",
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(
            create: ((context) => LoginProvider()),
          ),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
            useMaterial3: true,
          ),
          home: const MyLoginPage(),
        ));
  }
}
