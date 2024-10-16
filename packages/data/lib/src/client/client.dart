import 'package:chopper/chopper.dart';
import 'package:data/src/client/custom_serialize.dart';
import 'package:data/src/client/interceptors/index.dart';
import 'package:flutter/material.dart';
import 'package:shared/shared.dart';

abstract class Client {
  static ChopperClient createStagingClient(
    Logger logger,
    VoidCallback? onUnauthorized,
  ) {
    final interceptors = [
      ChopperLoggingInterceptor(logger),
      AuthInterceptor(),
    ];

    return ChopperClient(
      baseUrl: Uri.parse('https://testwork.shot.dinolab.com/api'),
      converter: JsonSerializableConverter.instance,
      interceptors: interceptors,
    );
  }
}
