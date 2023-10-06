import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'bloc/authentication_bloc.dart';
import 'events/firebase_options.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

import 'package:flutter_application_1/packages/authentication_service/lib/authentication_service.dart';

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
  final AuthenticationService authenticationService = AuthenticationService();
  await authenticationService.user.first;
  runApp(MyApp(authenticationSerivce: authenticationService));
}

class MyApp extends StatelessWidget {
  final AuthenticationService authenticationSerivce;

  const MyApp({Key? key, required this.authenticationSerivce})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationSerivce,
        child: MaterialApp(
          home: BlocProvider<AuthenticationBloc>(
            create: (_) => AuthenticationBloc(
                authenticationService: authenticationSerivce),
            child: const AppView(),
          ),
        ));
  }
}

class AppView extends StatelessWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthenticationBloc, AuthenticationState>(
        builder: (context, state) {
      return const Scaffold(
        body: MyLoginPage(),
      );
    });
  }
}
