import 'dart:developer';

import 'package:data/data_layer.dart';
import 'package:dino_lab/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:domain/domain_layer.dart';
import 'package:dino_lab/presentation/home/home_bloc/home_bloc.dart';
import 'package:dino_lab/router/app_router.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared/shared.dart';

final get = ServiceLocator.getIt;

class AppBootstrapper extends ServiceLocator {
  final _isInitialized = BehaviorSubject.seeded(false);
  static final instance = AppBootstrapper._();

  Stream<bool> get isInitializedStream => _isInitialized.asBroadcastStream();

  AppBootstrapper._();

  Future<void> initialize() async {
    try {
      ServiceLocator.initialize();

      registerSingleton<AppRouter>(AppRouter());

      await SharedBootstrapper.instance.initialize();
      await DomainLayerBootstrapper.instance.initialize();
      await DataLayerBootstrapper.instance.initialize();

      registerLazySingleton<HomeBloc>(
        () => HomeBloc(
          userRepository: get(),
        ),
      );

      registerFactory<AuthBloc>(
        () => AuthBloc(
          authRepository: get(),
        ),
      );

      _isInitialized.value = true;
    } on Object catch (e) {
      log('AppBootstrapper error: ${e.toString()}');
    }
  }
}
