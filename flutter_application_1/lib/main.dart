import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/packages/authentication_service/lib/authentication_service.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/authentication_bloc.dart';
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
    return RepositoryProvider(
        create: (context) => AuthenticationService(),
        child: BlocProvider(
            create: (context) => AuthenticationBloc(
                  authenticationService:
                      RepositoryProvider.of<AuthenticationService>(context),
                ),
            child: MaterialApp(
              title: 'Flutter Demo',
              theme: ThemeData(
                colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
                useMaterial3: true,
              ),
              home: const MyLoginPage(),
            )));
  }
}
