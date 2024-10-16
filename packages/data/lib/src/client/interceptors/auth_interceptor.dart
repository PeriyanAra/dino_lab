import 'dart:async';

import 'package:chopper/chopper.dart';
import 'package:data/src/common/index.dart';

class AuthInterceptor implements Interceptor {
  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final storage = SecureStorage();
    final response = await storage.read(SecureStorageConstants.accessTokenKey);

    if (response.isFailed || response.success == null) {
      return chain.proceed(chain.request);
    }

    final request = applyHeader(
        chain.request, 'Authorization', 'Bearer ${response.success}');

    return chain.proceed(request);
  }
}
