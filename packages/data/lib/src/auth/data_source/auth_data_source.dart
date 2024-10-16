import 'package:data/src/auth/dto/index.dart';
import 'package:shared/shared.dart';

abstract class AuthDataSource {
  Future<Result<AuthResponseDto, FailureResult>> register({
    required RegisterRequestDto registerRequestDto,
  });

  Future<Result<AuthResponseDto, FailureResult>> login({
    required LoginRequestDto loginRequestDto,
  });

  Future<Result<void, FailureResult>> saveTokens({
    required AuthResponseDto authResponseDto,
  });
}
