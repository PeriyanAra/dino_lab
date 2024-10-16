import 'dart:async';

import 'package:data/src/index.dart';
import 'package:domain/domain_layer.dart';
import 'package:shared/shared.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authRemoteDataSource;
  final AuthDataSource _authLocalDataSource;

  AuthRepositoryImpl({
    required AuthDataSource authRemoteDataSource,
    required AuthDataSource authLocalDataSource,
  })  : _authRemoteDataSource = authRemoteDataSource,
        _authLocalDataSource = authLocalDataSource;

  @override
  Future<Result<void, FailureResult>> login({
    required LoginRequestEntity loginRequestEntity,
  }) async {
    final response = await _authRemoteDataSource.login(
      loginRequestDto: LoginRequestDto.fromEntity(loginRequestEntity),
    );

    return response.when(
      success: (data) {
        unawaited(
          _authLocalDataSource.saveTokens(
            authResponseDto: data,
          ),
        );

        return const Result.success(null);
      },
      failure: Result.failure,
    );
  }

  @override
  Future<Result<void, FailureResult>> register({
    required RegisterRequestEntity registerRequestEntity,
  }) async {
    final response = await _authRemoteDataSource.register(
      registerRequestDto: RegisterRequestDto.fromEntity(registerRequestEntity),
    );

    return response.when(
      success: (data) {
        unawaited(
          _authLocalDataSource.saveTokens(
            authResponseDto: data,
          ),
        );

        return const Result.success(null);
      },
      failure: Result.failure,
    );
  }

  @override
  Future<Result<void, FailureResult>> logout() {
    return _authLocalDataSource.logout();
  }
}
