import 'package:data/data_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_entity.freezed.dart';

@freezed
class ProfileEntity with _$ProfileEntity {
  const factory ProfileEntity({
    required String name,
    required String email,
    required String avatar,
  }) = _ProfileEntity;

  factory ProfileEntity.fromDto(ProfileDto dto) {
    return ProfileEntity(
      name: dto.name,
      email: dto.email,
      avatar: dto.avatar,
    );
  }
}
