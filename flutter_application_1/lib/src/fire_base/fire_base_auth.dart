import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

class FirAuth {
  FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signUp(String email, String pass, String phone, String name,
      Function onSuccess) async {
    try {
      UserCredential result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: pass);
      User? user = result.user;
      _createUser(user!.uid, name, phone, onSuccess);
    } catch (e) {
      //TODO
      print(e.toString());
    }
  }

  _createUser(String userId, String name, String phone, Function onSuccess) {
    var user = {"name": name, "phone": phone};
    var ref = FirebaseDatabase.instance.ref().child("users");
    ref.child(userId).set(user).then((user) {
      // success
      onSuccess();
    }).catchError((err) {
      // error
    });
  }
}
