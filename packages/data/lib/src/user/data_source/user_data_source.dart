import 'package:data/src/user/dto/profile_dto.dart';
import 'package:shared/shared.dart';

abstract class UserDataSource {
  Future<Result<ProfileDto, FailureResult>> getUserProfile();
}
