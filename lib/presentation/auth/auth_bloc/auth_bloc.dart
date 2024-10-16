import 'dart:async';

import 'package:domain/domain_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_bloc.freezed.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepository _authRepository;
  AuthBloc({
    required AuthRepository authRepository,
  })  : _authRepository = authRepository,
        super(AuthState.initial()) {
    on<_AuthLoginEvent>(_handleLogin);
    on<_AuthRegisterEvent>(_handleRegister);
    on<_AuthLogoutEvent>(_handleLogout);
  }

  Future<void> _handleLogin(
    _AuthLoginEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthState.loading());

    final loginRequestEntity = LoginRequestEntity(
      email: event.email,
      password: event.password,
    );

    final response =
        await _authRepository.login(loginRequestEntity: loginRequestEntity);

    response.when(
      success: (_) => emit(AuthState.loaded()),
      failure: (f) => emit(
        AuthState.error(
          errorMessage: f.errorMessage,
        ),
      ),
    );
  }

  Future<void> _handleRegister(
    _AuthRegisterEvent event,
    Emitter<AuthState> emit,
  ) async {
    final registerRequestEntity = RegisterRequestEntity(
      email: event.email,
      name: event.name,
      password: event.password,
    );

    final response = await _authRepository.register(
        registerRequestEntity: registerRequestEntity);

    response.when(
      success: (_) => emit(AuthState.loaded()),
      failure: (f) => emit(
        AuthState.error(
          errorMessage: f.errorMessage,
        ),
      ),
    );
  }

  Future<void> _handleLogout(
    _AuthLogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    final response = await _authRepository.logout();

    response.when(
      success: (_) => emit(AuthState.loaded()),
      failure: (f) => emit(
        AuthState.error(
          errorMessage: f.errorMessage,
        ),
      ),
    );
  }
}
