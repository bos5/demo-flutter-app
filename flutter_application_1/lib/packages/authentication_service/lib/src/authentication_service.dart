import 'package:authentication_service/src/login_exception.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'models/models.dart';

extension on firebase_auth.User {
  User get toUser {
    return User(
      uid: uid,
      name: displayName,
      email: email,
      photo: photoURL,
    );
  }
}

class AuthenticationService {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;
  final FacebookAuth _facebookAuth;
  final CacheClient _cacheClient;
  static const String _userCache = 'user';

  AuthenticationService({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
    FacebookAuth? facebookAuth,
    CacheClient? cacheClient,
  })  : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _googleSignIn = googleSignIn ?? GoogleSignIn.standard(),
        _facebookAuth = facebookAuth ?? FacebookAuth.instance,
        _cacheClient = cacheClient ?? CacheClient();
  Stream<User?> get user => _firebaseAuth.authStateChanges().map((user) {
        _cacheClient.write(_userCache, user?.toUser);
        return user?.toUser;
      });
  User? get currentUser => _cacheClient.read(_userCache) ?? User.empty;
  Future<void> loginWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LoginWithEmailAndPasswordFailure.fromCode(e.code);
    }
  }

  Future<void> signUpWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    }
  }

  Future<void> loginWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return;
      final googleAuth = await googleUser.authentication;
      final credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      await _firebaseAuth.signInWithCredential(credential);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LoginWithGoogleFailure.fromCode(e.code);
    }
  }

  Future<void> loginWithFacebook() async {
    try {
      final LoginResult result = await _facebookAuth.login();
      if (result.status == LoginStatus.success) {
        final facebookAuthCredential =
            firebase_auth.FacebookAuthProvider.credential(
                result.accessToken!.token);
        await _firebaseAuth.signInWithCredential(facebookAuthCredential);
      }
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LoginWithFaceBookFailure.fromCode(e.code);
    }
  }
}
