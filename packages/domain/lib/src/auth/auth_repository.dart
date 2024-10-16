import 'package:domain/domain_layer.dart';
import 'package:shared/shared.dart';

abstract class AuthRepository {
  Future<Result<void, FailureResult>> register({
    required RegisterRequestEntity registerRequestEntity,
  });

  Future<Result<void, FailureResult>> login({
    required LoginRequestEntity loginRequestEntity,
  });

  Future<Result<void, FailureResult>> logout();
  

}
