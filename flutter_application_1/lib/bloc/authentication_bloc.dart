import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:authentication_service/authentication_service.dart';
import 'package:meta/meta.dart';
part 'authentication_event.dart';
part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final AuthenticationService _authenticationService;
  AuthenticationBloc({
    required AuthenticationService authenticationService,
  })  : _authenticationService = authenticationService,
        super((authenticationService.currentUser!.isEmpty)
            ? const AuthenticationInitial.unauthenticated()
            : AuthenticationInitial.authenticated(
                user: authenticationService.currentUser)) {
    on<AppUserChanged>(_appUserChanged);
    on<LogoutRequested>(_logOutRequested);
    // on
    _userStreamSubscription = _authenticationService.user.listen(
      (user) => add(AppUserChanged(user)),
    );
  }
  late final StreamSubscription<User?> _userStreamSubscription;
  Future<void> _appUserChanged(
    AppUserChanged event,
    Emitter<AuthenticationState> emit,
  ) async {
    if (event.user != null) {
      emit(AuthenticationInitial.authenticated(user: event.user));
    } else {
      emit(const AuthenticationInitial.unauthenticated());
    }
  }

  Future<void> _logOutRequested(
    LogoutRequested event,
    Emitter<AuthenticationState> emit,
  ) async {
    await _authenticationService.logout();
  }
}
