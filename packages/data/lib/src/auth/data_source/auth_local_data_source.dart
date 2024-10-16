import 'package:data/data_layer.dart';
import 'package:data/src/common/index.dart';
import 'package:shared/shared.dart';

class AuthLocalDataSource extends AuthDataSource {
  final SecureStorage _secureStorage;

  AuthLocalDataSource({
    required SecureStorage secureStorage,
  }) : _secureStorage = secureStorage;

  @override
  Future<Result<AuthResponseDto, FailureResult>> login(
      {required LoginRequestDto loginRequestDto}) {
    // TODO: implement login
    throw UnimplementedError();
  }

  @override
  Future<Result<AuthResponseDto, FailureResult>> register(
      {required RegisterRequestDto registerRequestDto}) {
    // TODO: implement register
    throw UnimplementedError();
  }

  @override
  Future<Result<void, FailureResult>> saveTokens({
    required AuthResponseDto authResponseDto,
  }) async {
    return _secureStorage.write(
      key: SecureStorageConstants.accessTokenKey,
      value: authResponseDto.accessToken,
    );
  }
}
