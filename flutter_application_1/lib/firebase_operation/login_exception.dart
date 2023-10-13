class LoginWithEmailAndPasswordFailure implements Exception {
  final String message;

  LoginWithEmailAndPasswordFailure(this.message);
  factory LoginWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'user-not-found':
        return LoginWithEmailAndPasswordFailure(
            'There is no user corresponding to this email address.');
      case 'wrong-password':
        return LoginWithEmailAndPasswordFailure(
            'The password is invalid for the given email address.');
      case 'too-many-requests':
        return LoginWithEmailAndPasswordFailure(
            'Too many requests. Try again later.');
      case 'network-request-failed':
        return LoginWithEmailAndPasswordFailure(
            'Network error. Try again later.');
      default:
        return LoginWithEmailAndPasswordFailure('An undefined Error happened.');
    }
  }
}

class SignUpWithEmailAndPasswordFailure implements Exception {
  final String message;

  SignUpWithEmailAndPasswordFailure(this.message);
  factory SignUpWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'email-already-in-use':
        return SignUpWithEmailAndPasswordFailure(
            'The email address is already in use by another account.');
      case 'invalid-email':
        return SignUpWithEmailAndPasswordFailure(
            'The email address is not valid.');
      case 'operation-not-allowed':
        return SignUpWithEmailAndPasswordFailure(
            'Email/password accounts are not enabled.');
      case 'weak-password':
        return SignUpWithEmailAndPasswordFailure(
            'The password is not strong enough.');
      case 'too-many-requests':
        return SignUpWithEmailAndPasswordFailure(
            'Too many requests. Try again later.');
      case 'network-request-failed':
        return SignUpWithEmailAndPasswordFailure(
            'Network error. Try again later.');
      default:
        return SignUpWithEmailAndPasswordFailure(
            'An undefined Error happened.');
    }
  }
}

class LoginWithFaceBookFailure implements Exception {
  final String message;
  LoginWithFaceBookFailure(this.message);
  factory LoginWithFaceBookFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return LoginWithFaceBookFailure(
            'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.');
      case 'invalid-credential':
        return LoginWithFaceBookFailure(
            'The credential data is malformed or has expired.');
      case 'operation-not-allowed':
        return LoginWithFaceBookFailure('Facebook accounts are not enabled.');
      case 'user-disabled':
        return LoginWithFaceBookFailure(
            'The user account has been disabled by an administrator.');
      case 'user-not-found':
        return LoginWithFaceBookFailure(
            'There is no user record corresponding to this identifier. The user may have been deleted.');
      case 'wrong-password':
        return LoginWithFaceBookFailure(
            'The password is invalid for the given email, or the account corresponding to the email does not have a password set.');
      case 'invalid-verification-code':
        return LoginWithFaceBookFailure(
            'The credential verification code is not valid.');
      case 'invalid-verification-id':
        return LoginWithFaceBookFailure(
            'The credential verification ID is not valid.');
      case 'too-many-requests':
        return LoginWithFaceBookFailure('Too many requests. Try again later.');
      case 'network-request-failed':
        return LoginWithFaceBookFailure('Network error. Try again later.');
      default:
        return LoginWithFaceBookFailure('An undefined Error happened.');
    }
  }
}

class LoginWithGoogleFailure implements Exception {
  final String message;
  LoginWithGoogleFailure(this.message);
  factory LoginWithGoogleFailure.fromCode(String code) {
    switch (code) {
      case 'account-exists-with-different-credential':
        return LoginWithGoogleFailure(
            'An account already exists with the same email address but different sign-in credentials. Sign in using a provider associated with this email address.');
      case 'invalid-credential':
        return LoginWithGoogleFailure(
            'The credential data is malformed or has expired.');
      case 'operation-not-allowed':
        return LoginWithGoogleFailure('Google accounts are not enabled.');
      case 'user-disabled':
        return LoginWithGoogleFailure(
            'The user account has been disabled by an administrator.');
      case 'user-not-found':
        return LoginWithGoogleFailure(
            'There is no user record corresponding to this identifier. The user may have been deleted.');
      case 'wrong-password':
        return LoginWithGoogleFailure(
            'The password is invalid for the given email, or the account corresponding to the email does not have a password set.');
      case 'invalid-verification-code':
        return LoginWithGoogleFailure(
            'The credential verification code is not valid.');
      case 'invalid-verification-id':
        return LoginWithGoogleFailure(
            'The credential verification ID is not valid.');
      case 'too-many-requests':
        return LoginWithGoogleFailure('Too many requests. Try again later.');
      case 'network-request-failed':
        return LoginWithGoogleFailure('Network error. Try again later.');
      default:
        return LoginWithGoogleFailure('An undefined Error happened.');
    }
  }
}

class ResetPassworkFailure implements Exception {
  final String message;
  ResetPassworkFailure(this.message);
  factory ResetPassworkFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return ResetPassworkFailure('The email address is not valid.');
      case 'user-not-found':
        return ResetPassworkFailure(
            'There is no user corresponding to this email address.');
      case 'too-many-requests':
        return ResetPassworkFailure('Too many requests. Try again later.');
      case 'network-request-failed':
        return ResetPassworkFailure('Network error. Try again later.');
      default:
        return ResetPassworkFailure('An undefined Error happened.');
    }
  }
}
