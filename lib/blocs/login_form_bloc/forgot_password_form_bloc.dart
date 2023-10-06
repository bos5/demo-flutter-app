import 'dart:async';

import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:login/features/auth/auth.dart';

class ForgotPasswordFormBloc extends FormBloc<String, String> {
  final email = TextFieldBloc(
    validators: [
      FieldBlocValidators.required,
    ],
  );
  ForgotPasswordFormBloc() {
    addFieldBlocs(
      fieldBlocs: [
        email,
      ],
    );
  }

  @override
  FutureOr<void> onSubmitting() async {
    try {
      await Auth().sendResetPassword(email: email.value);
      emitSuccess();
      
    } on Exception catch (e) {
      emitFailure(failureResponse: e.toString());
    }
  }
}
