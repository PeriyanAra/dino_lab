import 'package:chopper/chopper.dart';
import 'package:data/data_layer.dart';

part 'auth_api_service.chopper.dart';

@ChopperApi()
abstract class AuthApiService extends ChopperService {
  static AuthApiService create({ChopperClient? client}) {
    return _$AuthApiService(client);
  }

  @Post(path: 'login')
  Future<Response<AuthResponseDto>> login({
    @Body() required Map<String, dynamic> body,
  });

  @Post(path: 'register')
  Future<Response<AuthResponseDto>> register({
    @Body() required Map<String, dynamic> body,
  });
}
