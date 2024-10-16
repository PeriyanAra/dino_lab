import 'package:flutter/foundation.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:shared/shared.dart';

class SecureStorage {
  factory SecureStorage() => _instance ??= SecureStorage._();

  SecureStorage._() {
    _storage = const FlutterSecureStorage();
  }

  static SecureStorage? _instance;

  late final FlutterSecureStorage _storage;

  Future<Result<String?, FailureResult>> read(String key) async {
    try {
      final response = await _storage.read(key: key);

      return Result.success(response);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        FailureResult(
          debugMessage: e.toString(),
          reason: FailureReasons.unknown,
        ),
      );
    }
  }

  Future<Result<void, FailureResult>> write({
    required String key,
    required String value,
  }) async {
    try {
      await _storage.write(key: key, value: value);

      return const Result.success(null);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        FailureResult(
          debugMessage: e.toString(),
          reason: FailureReasons.unknown,
        ),
      );
    }
  }

  Future<Result<void, FailureResult>> delete({
    required String key,
  }) async {
    try {
      await _storage.delete(
        key: key,
      );

      return const Result.success(null);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        FailureResult(
          debugMessage: e.toString(),
          reason: FailureReasons.unknown,
        ),
      );
    }
  }

  Future<Result<void, FailureResult>> deleteAll({
    required String key,
  }) async {
    try {
      await _storage.deleteAll();

      return const Result.success(null);
    } catch (e) {
      debugPrint(e.toString());

      return Result.failure(
        FailureResult(
          debugMessage: e.toString(),
          reason: FailureReasons.unknown,
        ),
      );
    }
  }
}
