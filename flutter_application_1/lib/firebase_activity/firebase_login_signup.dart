import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/home_screen.dart';
import 'package:flutter_application_1/screens/login_page.dart';
import 'package:flutter_application_1/utils/popup.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:provider/provider.dart';
// import 'package:google_sign_in/google_sign_in.dart';

class LoginProvider extends ChangeNotifier {
  bool _isSignedIn = false;
  bool get value => _isSignedIn;
  bool _hasError = false;
  bool get hasError => _hasError;
  String? _name;
  String? get name => _name;
  String? _email;
  String? get email => _email;
  String? _photoUrl;
  String? get photoUrl => _photoUrl;
  String? _uid;
  String? get uid => _uid;
  String? _provider;
  String? get provider => _provider;
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  LoginProvider() {
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

  Future<void> signInWithFacebook() async {
    final LoginResult result = await facebookAuth.login();
    if (result.status == LoginStatus.success) {
      final AccessToken accessToken = result.accessToken!;
      final OAuthCredential credential =
          FacebookAuthProvider.credential(accessToken.token);
      final UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User? user = userCredential.user;
      _name = user!.displayName;
      _email = user.email;
      _photoUrl = user.photoURL;
      _uid = user.uid;
      _provider = 'Facebook';
      notifyListeners();
    } else {
      _hasError = true;
      notifyListeners();
    }
  }
  // Future<void> signInWithGoogle() async {
  //   final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
  //   if (googleUser == null) {
  //     _hasError = true;
  //     notifyListeners();
  //   } else {
  //     final GoogleSignInAuthentication googleAuth =
  //         await googleUser.authentication;
  //     final OAuthCredential credential = GoogleAuthProvider.credential(
  //       accessToken: googleAuth.accessToken,
  //       idToken: googleAuth.idToken,
  //     );
  //     final UserCredential userCredential =
  //         await FirebaseAuth.instance.signInWithCredential(credential);
  //     final User? user = userCredential.user;
  //     _name = user!.displayName;
  //     _email = user.email;
  //     _photoUrl = user.photoURL;
  //     _uid = user.uid;
  //     _provider = 'Google';
  //     notifyListeners();
  //   }
  // }

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
