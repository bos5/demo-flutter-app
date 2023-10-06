import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/utils/navigate_page.dart';
import 'package:flutter_application_1/utils/popup.dart';
// import 'package:provider/provider.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginEvent {
  final BuildContext context;
  final TextEditingController emailContrl;
  final TextEditingController passwordContrl;
  final bool value;
  final List<bool> validate;

  LoginEvent(this.context, this.emailContrl, this.passwordContrl, this.value,
      this.validate);
}

loginWithEmail(BuildContext context, TextEditingController emailContrl,
    TextEditingController passwordContrl) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(
          email: emailContrl.text, password: passwordContrl.text)
      .then((value) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const MyHomePage(),
      ),
    );
  }).catchError((error) {
    showdialog(context, 'Sign in', error.toString());
  });
}

signUpWithEmail(BuildContext context, TextEditingController emailContrl,
    TextEditingController passwordContrl, bool value, List<bool> validate) {
  if (validate.contains(true) || !value) {
    return;
  } else {
    FirebaseAuth.instance
        .createUserWithEmailAndPassword(
            email: emailContrl.text, password: passwordContrl.text)
        .then((value) {
      navigatePage(context, const MyLoginPage());
    }).onError((error, stackTrace) {
      print(error.toString());
    }).then((value) {
      showdialog(context, 'Sign up', 'Sign up success!');
    }).catchError((error) {
      showdialog(context, 'Sign up', error.toString());
    });
  }
}
