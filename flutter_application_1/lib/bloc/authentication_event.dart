part of 'authentication_bloc.dart';

@immutable
sealed class AuthenticationEvent {
  const AuthenticationEvent();
}

class AppUserChanged extends AuthenticationEvent {
  const AppUserChanged(this.user);

  final User user;
}

class LogoutRequested extends AuthenticationEvent {
  const LogoutRequested();
}
