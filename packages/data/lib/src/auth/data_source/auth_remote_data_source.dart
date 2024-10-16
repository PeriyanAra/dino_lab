import 'package:data/data_layer.dart';
import 'package:data/src/client/index.dart';
import 'package:shared/shared.dart';

class AuthRemoteDataSource extends AuthDataSource {
  final AuthApiService _authApiService;

  AuthRemoteDataSource({
    required AuthApiService authApiService,
  }) : _authApiService = authApiService;

  @override
  Future<Result<AuthResponseDto, FailureResult>> login({
    required LoginRequestDto loginRequestDto,
  }) {
    return ApiRequestManager.guardApiCall<AuthResponseDto, AuthResponseDto>(
      invoker: () => _authApiService.login(
        body: loginRequestDto.toJson(),
      ),
      mapper: (data) => data,
    );
  }

  @override
  Future<Result<AuthResponseDto, FailureResult>> register({
    required RegisterRequestDto registerRequestDto,
  }) {
    return ApiRequestManager.guardApiCall<AuthResponseDto, AuthResponseDto>(
      invoker: () => _authApiService.register(
        body: registerRequestDto.toJson(),
      ),
      mapper: (data) => data,
    );
  }

  @override
  Future<Result<void, FailureResult>> saveTokens({
    required AuthResponseDto authResponseDto,
  }) {
    // TODO: implement saveTokens
    throw UnimplementedError();
  }
}
