import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/utils/navigate_page.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
            padding: const EdgeInsets.all(5),
            onPressed: () async {
              try {
                // await handleFaceBookAuth();
              } catch (e) {
                print(e);
              }
            },
            icon: Icon(
              FontAwesomeIcons.facebook,
              size: 40,
              color: Colors.blue[900],
            )),
        IconButton(
            onPressed: () {
              // FirebaseAuth.instance.;
            },
            icon: Icon(
              FontAwesomeIcons.google,
              size: 40,
              color: Colors.red[900],
            )),
        IconButton(
            padding: const EdgeInsets.all(5),
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.twitter,
              size: 40,
              color: Colors.blue,
            )),
      ],
    );
  }

  Future<UserCredential> handleFaceBookAuth() async {
    final LoginResult result = await FacebookAuth.instance.login();
    print(result.status);
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    return FirebaseAuth.instance.signInWithCredential(facebookAuthCredential);
  }
}
