part of 'home_bloc.dart';

@freezed
class HomeState with _$HomeState {

  const factory HomeState.loading() = HomeLoadingState;

  const factory HomeState.loaded({
    required ProfileViewModel profileViewModel,
  }) = HomeLoadedState;

  const factory HomeState.error({
    required String? errorMessage,
  }) = HomeErrorState;
}
