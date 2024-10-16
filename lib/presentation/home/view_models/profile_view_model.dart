import 'package:domain/domain_layer.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'profile_view_model.freezed.dart';

@freezed
class ProfileViewModel with _$ProfileViewModel {
  const factory ProfileViewModel({
    required String name,
    required String email,
    required String avatar,
  }) = _ProfileViewModel;

  factory ProfileViewModel.fromEntity(ProfileEntity entity) {
    return ProfileViewModel(
      name: entity.name,
      email: entity.email,
      avatar: entity.avatar,
    );
  }
}
