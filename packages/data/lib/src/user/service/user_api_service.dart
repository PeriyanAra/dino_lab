import 'package:chopper/chopper.dart';
import 'package:data/src/user/dto/index.dart';


part 'user_api_service.chopper.dart';

@ChopperApi()
abstract class UserApiService extends ChopperService {
  static UserApiService create({ChopperClient? client}) {
    return _$UserApiService(client);
  }

 


  @Get(path: 'me')
  Future<Response<ProfileDto>> getUserProfile();
}
