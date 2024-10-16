import 'package:domain/domain_layer.dart';
import 'package:shared/shared.dart';

abstract class UserRepository {
  Future<Result<ProfileEntity, FailureResult>> getUserProfile();
}
