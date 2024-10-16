part of 'auth_bloc.dart';

@freezed
class AuthEvent with _$AuthEvent {
  const factory AuthEvent.login({
    required String email,
    required String password,
  }) = _AuthLoginEvent;

  const factory AuthEvent.register({
    required String email,
    required String name,
    required String password,
  }) = _AuthRegisterEvent;
}
