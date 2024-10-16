import 'package:domain/domain_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'register_request_dto.freezed.dart';
part 'register_request_dto.g.dart';

@freezed
class RegisterRequestDto with _$RegisterRequestDto {
  const factory RegisterRequestDto({
    required String name,
    required String email,
    required String password,
  }) = _RegisterRequestDto;

  factory RegisterRequestDto.fromJson(Map<String, Object?> json) =>
      _$RegisterRequestDtoFromJson(json);

  factory RegisterRequestDto.fromEntity(RegisterRequestEntity entity) {
    return RegisterRequestDto(
      name: entity.name,
      email: entity.email,
      password: entity.password,
    );
  }
}
