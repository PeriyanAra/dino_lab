import 'package:data/src/user/data_source/index.dart';
import 'package:domain/domain_layer.dart';
import 'package:shared/shared.dart';

class UserRepositoryImpl implements UserRepository {
  final UserDataSource _userDataSource;

  UserRepositoryImpl({
    required UserDataSource userDataSource,
  }) : _userDataSource = userDataSource;

  @override
  Future<Result<ProfileEntity, FailureResult>> getUserProfile() async {
    final profileResponse = await _userDataSource.getUserProfile();

    return profileResponse.when(
      success: (dto) => Result.success(
        ProfileEntity.fromDto(dto),
      ),
      failure: Result.failure,
    );
  }
}
