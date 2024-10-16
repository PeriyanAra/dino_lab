import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_dto.freezed.dart';
part 'profile_dto.g.dart';

@freezed
class ProfileDto with _$ProfileDto {
  const factory ProfileDto({
    required String name,
    required String email,
    required String avatar,
  }) = _ProfileDto;

  factory ProfileDto.fromJson(Map<String, Object?> json) => _$ProfileDtoFromJson(json);

}
