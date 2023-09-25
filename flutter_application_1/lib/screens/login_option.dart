import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/utils/navigate_page.dart';
import 'package:flutter_application_1/utils/popup.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter_application_1/firebase_activity/firebase_login_signup.dart';
import 'package:provider/provider.dart';

class LoginOption extends StatelessWidget {
  const LoginOption({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ButtonTheme(
        child: ButtonBar(
      alignment: MainAxisAlignment.center,
      children: [
        IconButton(
            onPressed: () {
              handleFacebookAuth(context, false);
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
            onPressed: () {},
            icon: const Icon(
              FontAwesomeIcons.twitter,
              size: 40,
              color: Colors.blue,
            )),
      ],
    ));
  }

  Future handleFacebookAuth(context, isSignedIn) async {
    final loginProvider = context.read<LoginProvider>();
    await loginProvider.signInWithFacebook().then((value) {
      if (loginProvider.hasError) {
        showdialog(context, 'Error', 'Something went wrong');
      } else {
        replacePage(context, const MyHomePage());
      }
    });
  }
}
