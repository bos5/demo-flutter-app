import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/popup.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';

class FireBaseLoginSignUp {
  final FirebaseAuth firebaseAuth;
  FireBaseLoginSignUp({required this.firebaseAuth});
  User? user;
  loginWithEmail(String emailContrl, String passwordContrl) async {
    await firebaseAuth
        .signInWithEmailAndPassword(
            email: emailContrl, password: passwordContrl)
        .then((value) => user = value.user);
    return user;
  }

  resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}

class FacebookLogInSignUp {
  final FacebookAuth facebookAuth;
  FacebookLogInSignUp({required this.facebookAuth});
  User? user;
  handleFaceBookAuth() async {
    final LoginResult result = await facebookAuth.login();
    print(result.status);
    final OAuthCredential facebookAuthCredential =
        FacebookAuthProvider.credential(result.accessToken!.token);
    await FirebaseAuth.instance
        .signInWithCredential(facebookAuthCredential)
        .then((value) {
      user = value.user;
    });
  }
}

loginWithEmail(String emailContrl, String passwordContrl) {
  FirebaseAuth.instance
      .signInWithEmailAndPassword(email: emailContrl, password: passwordContrl)
      .catchError((error) {
    print(error.toString());
    // showdialog(context, 'Sign in', error.toString());
  });
  User? user = FirebaseAuth.instance.currentUser;
  print(user!.email);
  return user;
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
      // navigatePage(context, const MyLoginPage(authenticationService: ,));
    }).onError((error, stackTrace) {
      print(error.toString());
    }).then((value) {
      showdialog(context, 'Sign up', 'Sign up success!');
    }).catchError((error) {
      showdialog(context, 'Sign up', error.toString());
    });
  }
}
