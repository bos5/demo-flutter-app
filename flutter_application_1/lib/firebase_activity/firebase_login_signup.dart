import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/utils/popup.dart';
import 'package:provider/provider.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginPrivider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get value => _isSignedIn;
  LoginPrivider() {
    checkSignInUser();
  }
  Future<void> checkSignInUser() async {
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        _isSignedIn = false;
        notifyListeners();
      } else {
        _isSignedIn = true;
        notifyListeners();
      }
    });
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser!.authentication;
    final OAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
  }

  void changeValue(bool value) {
    _isSignedIn = value;
    notifyListeners();
  }
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
  }).onError((error, stackTrace) {
    print(error.toString());
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
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const MyLoginPage(),
        ),
      );
    }).onError((error, stackTrace) {
      print(error.toString());
    }).then((value) {
      showdialog(context, 'Sign up', 'Sign up success!');
    }).catchError((error) {
      showdialog(context, 'Sign up', error.toString());
    });
  }
}
