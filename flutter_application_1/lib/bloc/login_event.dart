part of 'login_bloc.dart';

abstract class LoginEvent {
  const LoginEvent();
}

class LoginButtonPressed extends LoginEvent {
  final String email;
  final String password;

  const LoginButtonPressed({
    required this.email,
    required this.password,
  });
}

class FacebookLoginPress extends LoginEvent {}

class EmailChanged extends LoginEvent {
  final String email;

  const EmailChanged({required this.email});
}

class PasswordChanged extends LoginEvent {
  final String password;

  const PasswordChanged({required this.password});
}
