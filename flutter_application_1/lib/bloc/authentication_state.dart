part of 'authentication_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

@immutable
sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {
  final AppStatus status;
  final User? user;
  const AuthenticationInitial._(
    this.user, {
    required this.status,
  });
  const AuthenticationInitial.authenticated({required User? user})
      : this._(user, status: AppStatus.authenticated);
  const AuthenticationInitial.unauthenticated()
      : this._(null, status: AppStatus.unauthenticated);

  @override
  List<Object?> get props => throw UnimplementedError();
}
