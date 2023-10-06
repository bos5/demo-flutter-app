import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:login/features/auth/auth.dart';

class LoginFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );

  final password = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  final confirmPassword = TextFieldBloc(
    validators: [FieldBlocValidators.required],
  );

  LoginFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
        password,
      ],
    );
  }

  @override
  void onSubmitting() async {
    debugPrint(email.value);
    debugPrint(password.value);
    try {
      await Auth().signInWithEmailAndPassword(
        email: email.value,
        password: password.value,
      );
      emitSuccess();
    } on Exception catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
