import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_entity.freezed.dart';

@freezed
class RegisterRequestEntity with _$RegisterRequestEntity {
  const factory RegisterRequestEntity({
    required String email,
    required String name,
    required String password,
  }) = _RegisterRequestEntity;
}
