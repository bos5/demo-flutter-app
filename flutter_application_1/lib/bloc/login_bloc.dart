import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_application_1/firebase_operation/firebase_login_signup.dart';
import 'package:flutter_application_1/firebase_operation/login_exception.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
// import 'package:google_sign_in/google_sign_in.dart';
// import 'package:meta/meta.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final _eventController = StreamController<LoginEvent>();
  StreamSink<LoginEvent> get eventSink => _eventController.sink;
  final _stateController = StreamController<LoginState>();
  Stream<LoginState> get stateStream => _stateController.stream;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonPressed>(onLoginButtonPressed);
    on<FacebookLoginPress>(onFacebookLoginPressed);
  }

  // void _mapEventToState(LoginEvent event) async {
  //   print("map event to state");
  //   if (event is LoginButtonPressed) {
  //     try {
  //       // await FireBaseLoginSignUp().loginWithEmail(event.email, event.password);
  //       // await FireBaseLoginSignUp()
  //       //     .loginWithEmail(event.email, event.password)
  //       //     .then((value) {
  //       //   _stateController.add(LoginSuccess(value.user!));
  //       // });
  //       // loginWithEmail(emaill, passwordd!);
  //       User user = await FireBaseLoginSignUp(firebaseAuth: firebaseAuth)
  //           .loginWithEmail(event.email, event.password);
  //       _stateController.add(LoginSuccess(user));
  //       print(_stateController.stream.first);
  //     } on LoginWithEmailAndPasswordFailure catch (e) {
  //       _stateController.add(LoginFailure(e.message));
  //       print(e);
  //     }
  //   } else if (event is FacebookLoginPress) {
  //     try {
  //       await FireBaseLoginSignUp(firebaseAuth: firebaseAuth)
  //           .handleFaceBookAuth()
  //           .then((value) {
  //         print(value!.email);
  //         _stateController.add(LoginSuccess(value.user!));
  //       });
  //     } on LoginWithFaceBookFailure catch (e) {
  //       print(e);
  //     }
  //   }
  // }

  void onLoginButtonPressed(event, Emitter emitter) async {
    try {
      User user = await FireBaseLoginSignUp(firebaseAuth: firebaseAuth)
          .loginWithEmail(event.email, event.password);
      emitter(LoginSuccess(user));
      // loginWithEmail(emaill, passwordd!);
    } on LoginWithEmailAndPasswordFailure catch (e) {
      print(e);
    }
  }

  void onFacebookLoginPressed(event, Emitter emitter) async {
    try {
      User user = await FacebookLogInSignUp(facebookAuth: facebookAuth)
          .handleFaceBookAuth();
      emitter(LoginSuccess(user));
    } on LoginWithFaceBookFailure catch (e) {
      print(e);
    }
  }

  // Clean up controllers
  void dispose() {
    _eventController.close();
    _stateController.close();
  }
}
