import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess, Function(String) onRegisterError) {
    _firebaseAuth
        .createUserWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      _createUser(user.user!.uid, name, phone, onSuccess, onRegisterError);
    }).catchError((err) {
      _onSignUpErr(err.code, onRegisterError);
    });
  }

  void signIn(String email, String pass, Function onSuccess,
      Function(String) onSignInError) {
    _firebaseAuth
        .signInWithEmailAndPassword(email: email, password: pass)
        .then((user) {
      // login success
      onSuccess();
    }).catchError((err) {
      onSignInError("Sign in fail, please try again");
    });
  }

  _createUser(String userId, String name, String phone, Function onSuccess,
      Function(String) onRegisterError) {
    var user = {"name": name, "phone": phone};
    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userId).set(user).then((user) {
      // success
      onSuccess();
    }).catchError((err) {
      // error
      onRegisterError("Signup failed, please try again!");
    });
  }

  void _onSignUpErr(String code, Function(String) onRegisterError) {
    switch (code) {
      case "email-already-in-use":
        onRegisterError("Email has existed");
        break;
      case "invalid-email":
        onRegisterError("Invalid email");
        break;
      case "weak-password":
        onRegisterError("The password is not strong enough");
        break;
      case "operation-not-allowed":
        onRegisterError("Email/password authentication hasn't been enabled");
        break;
      default:
        onRegisterError("Signup failed, please try again!");
        break;
    }
  }
}
