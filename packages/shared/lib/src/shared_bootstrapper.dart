import 'dart:developer';

import 'package:shared/src/index.dart';

class SharedBootstrapper extends ServiceLocator {
  static final instance = SharedBootstrapper._();

  SharedBootstrapper._();

  Future<void> initialize() async {
    try {
      registerLazySingleton<Logger>(() => Logger.factory(false));
    } on Object catch (e) {
      log('SharedBootstrapper error: ${e.toString()}');
    }

    await allReady();
  }
}
