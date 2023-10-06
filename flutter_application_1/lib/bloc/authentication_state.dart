part of 'authentication_bloc.dart';

enum AppStatus { authenticated, unauthenticated }

@immutable
sealed class AuthenticationState extends Equatable {
  const AuthenticationState();
}

final class AuthenticationInitial extends AuthenticationState {
  final AppStatus status;
  final User user;
  const AuthenticationInitial._({
    required this.status,
    this.user = User.empty,
  });
  const AuthenticationInitial.authenticated({required User user})
      : this._(status: AppStatus.authenticated, user: user);
  const AuthenticationInitial.unauthenticated()
      : this._(status: AppStatus.unauthenticated);

  @override
  List<Object?> get props => throw UnimplementedError();
}
