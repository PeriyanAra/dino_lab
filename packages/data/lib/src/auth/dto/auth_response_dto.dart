import 'package:freezed_annotation/freezed_annotation.dart';

part 'auth_response_dto.freezed.dart';
part 'auth_response_dto.g.dart';

@freezed
class AuthResponseDto with _$AuthResponseDto {
  const factory AuthResponseDto({
    @JsonKey(name: 'access_token') required String accessToken,
  }) = _AuthResponseDto;

  factory AuthResponseDto.fromJson(Map<String, Object?> json) =>
      _$AuthResponseDtoFromJson(json);
}
