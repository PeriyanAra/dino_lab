import 'dart:async';

import 'package:dino_lab/presentation/home/view_models/index.dart';
import 'package:domain/domain_layer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'home_event.dart';
part 'home_state.dart';
part 'home_bloc.freezed.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final UserRepository _userRepository;

  HomeBloc({
    required UserRepository userRepository,
  })  : _userRepository = userRepository,
        super(const HomeState.loading()) {
    on<_HomeGetUserProfileEvent>(_handleGetUserProfile);
  }

  Future<void> _handleGetUserProfile(
    _HomeGetUserProfileEvent event,
    Emitter<HomeState> emit,
  ) async {
    final response = await _userRepository.getUserProfile();

    response.when(
      success: (profile) => emit(
        HomeState.loaded(
          profileViewModel: ProfileViewModel.fromEntity(profile),
        ),
      ),
      failure: (f) => emit(
        HomeState.error(
          errorMessage: f.errorMessage,
        ),
      ),
    );
  }
}
