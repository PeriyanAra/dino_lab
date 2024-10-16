import 'package:data/data_layer.dart';
import 'package:data/src/client/index.dart';
import 'package:data/src/common/index.dart';
import 'package:domain/domain_layer.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

class DataLayerBootstrapper extends ServiceLocator {
  static final instance = DataLayerBootstrapper._();

  DataLayerBootstrapper._();

  Future<void> initialize({VoidCallback? onUnauthorized}) async {
    final chopperStagingClient =
        Client.createStagingClient(get(), onUnauthorized);

    //Services
    registerLazySingleton<SecureStorage>(
      SecureStorage.new,
    );


    //Api Services
    registerLazySingleton<UserApiService>(
      () => UserApiService.create(client: chopperStagingClient),
    );

    registerLazySingleton<AuthApiService>(
      () => AuthApiService.create(client: chopperStagingClient),
    );

    // Data sources
    registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSource(
        userApiService: get(),
      ),
    );

    registerLazySingleton<AuthRemoteDataSource>(
      () => AuthRemoteDataSource(
        authApiService: get(),
      ),
    );

      registerLazySingleton<AuthLocalDataSource>(
      () => AuthLocalDataSource(
        secureStorage: get(),
      ),
    );

    // Repository implementations
    registerLazySingleton<UserRepository>(
      () => UserRepositoryImpl(
        userDataSource: get<UserRemoteDataSource>(),
      ),
    );

    registerLazySingleton<AuthRepository>(
      () => AuthRepositoryImpl(
        authRemoteDataSource: get<AuthRemoteDataSource>(),
        authLocalDataSource: get<AuthLocalDataSource>(),
      ),
    );
  }
}
