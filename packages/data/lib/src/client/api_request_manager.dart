import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:chopper/chopper.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared/shared.dart';

const _clientTimeoutSeconds = 30;

abstract class ApiRequestManager {
  static Future<Result<T, FailureResult>> guardApiCall<T, TSource>({
    required Future<Response<TSource>> Function() invoker,
    FutureOr<T> Function(TSource)? mapper,
    FutureOr<T> Function(Response<TSource>)? responseMapper,
    Future<T> Function()? fallbackInvoker,
    Future<void> Function(T)? saveCacheInvoker,
    bool Function(int code, Map<String, String> headers, String body)?
        fallbackValidator,
    T Function(Response<TSource> response)? fallbackMapper,
    T? defaultValue,
    Connectivity? mockConnectivity,
  }) async {
    try {
      final connectivity = mockConnectivity ?? Connectivity();
      final connectivityResult = await connectivity.checkConnectivity();

      if (connectivityResult.contains(ConnectivityResult.none) &&
          fallbackInvoker != null) {
        final fallbackResponse = await fallbackInvoker()
            .timeout(const Duration(seconds: _clientTimeoutSeconds));

        return Result.success(fallbackResponse);
      }

      final response = await invoker()
          .timeout(const Duration(seconds: _clientTimeoutSeconds));
      if (response.isSuccessful) {
        final body = response.body;

        if (body != null && mapper != null) {
          final successResult = await mapper(body);
          await saveCacheInvoker?.call(successResult);

          return Result.success(successResult);
        } else if (responseMapper != null) {
          final successResult = await responseMapper(response);
          await saveCacheInvoker?.call(successResult);

          return Result.success(successResult);
        } else {
          return Result.success(defaultValue ?? null as T);
        }
      } else {
        String? errorMessage;
        try {
          final errorResponse = jsonDecode(response.bodyString) as Map;
          if (errorResponse['errors'] is List &&
              (errorResponse['errors'] as List).isNotEmpty) {
            final errors = errorResponse['errors'] as List;
            if (errors.isNotEmpty && errors.first is Map) {
              errorMessage = errors.first['description'];
            }
          }
        } catch (e) {
          debugPrint(e.toString());
        }

        return Result.failure(
          FailureResult(
            reason: FailureReasons.unknown,
            debugMessage: '${response.statusCode} on '
                '${response.base.request?.method} ${response.base.request?.url} | '
                'Body: ${response.bodyString}',
            errorMessage: errorMessage ?? response.bodyString,
          ),
        );
      }
    } on SocketException catch (ex) {
      return Result.failure(
        FailureResult(
          reason: FailureReasons.noInternetConnection,
          debugMessage: ex.toString(),
          errorMessage: ex.message,
        ),
      );
    } on TimeoutException catch (ex) {
      return Result.failure(
        FailureResult(
          reason: FailureReasons.timeout,
          debugMessage:
              '${ex.toString()}\n Please check your VPN configuration.',
          errorMessage: 'Please check your VPN configuration',
        ),
      );
    } on http.ClientException catch (ex) {
      return Result.failure(
        FailureResult(
          reason: FailureReasons.unknown,
          debugMessage: ex.toString(),
          errorMessage: ex.message,
        ),
      );
    } catch (ex) {
      return Result.failure(
        FailureResult(
          reason: FailureReasons.unknown,
          debugMessage: ex.toString(),
          errorMessage: ex.toString(),
        ),
      );
    }
  }
}
