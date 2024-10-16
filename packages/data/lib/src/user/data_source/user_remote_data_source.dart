import 'package:data/src/client/index.dart';
import 'package:data/src/user/data_source/user_data_source.dart';
import 'package:data/src/user/dto/profile_dto.dart';
import 'package:data/src/user/service/index.dart';
import 'package:shared/shared.dart';

class UserRemoteDataSource extends UserDataSource {
  final UserApiService _userApiService;

  UserRemoteDataSource({
    required UserApiService userApiService,
  }) : _userApiService = userApiService;

  @override
  Future<Result<ProfileDto, FailureResult>> getUserProfile() {
    return ApiRequestManager.guardApiCall<ProfileDto, ProfileDto>(
      invoker: _userApiService.getUserProfile,
      mapper: (dto) => dto,
    );
  }
}
