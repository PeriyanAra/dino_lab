import 'dart:async';
import 'dart:convert';

import 'package:chopper/chopper.dart';
import 'package:http/http.dart' as http;
import 'package:loggy/loggy.dart';
import 'package:shared/shared.dart';

class ChopperLoggingInterceptor implements Interceptor {
  static const _maxWidth = 90;
  final _value = StringBuffer();

  final Logger _logger;
  final bool showBody;
  final bool showHeader;

  
  factory ChopperLoggingInterceptor(Logger logger) =>
      ChopperLoggingInterceptor._(logger);

  ChopperLoggingInterceptor._(
    this._logger, {
    this.showBody = true,
    this.showHeader = true,
  });

  factory ChopperLoggingInterceptor.all(Logger logger) =>
      ChopperLoggingInterceptor._(
        logger,
        showBody: true,
        showHeader: true,
      );

  factory ChopperLoggingInterceptor.body(Logger logger) =>
      ChopperLoggingInterceptor._(
        logger,
        showBody: true,
      );

  factory ChopperLoggingInterceptor.header(Logger logger) =>
      ChopperLoggingInterceptor._(
        logger,
        showHeader: true,
      );

  void logPrint(String value) {
    if (_value.isEmpty) {
      _value.write(value);
    } else {
      _value.write('\n$value');
    }
  }

  void _printResponse(Response<Object?> response) {
    final Object? data = response.bodyString;

    if (data != null) {
      _prettyPrintObject(data, header: 'Body');
    }
  }

  void _prettyPrintObject(Object data, {String? header}) {
    String value;

    try {
      final object = const JsonDecoder().convert(data.toString()) as Object;
      const json = JsonEncoder.withIndent('    ');
      value = json.convert(object);
    } catch (e) {
      value = data.toString();
    }

    value = '║  ${value.trim().replaceAll('\n', '\n║  ')}';

    logPrint('╔  $header');
    logPrint('║');
    logPrint(value);
    logPrint('║');
    _printLine(pre: '╚');
  }

  void _printResponseHeader(Response<Object?> response) {
    final uri = response.base.request?.url;
    final method = response.base.request?.method;

    logPrint(
      '$method │ ${response.statusCode} ${response.base.reasonPhrase} │ ${uri.toString()}',
    );
  }

  void _printRequestHeader(http.BaseRequest? options) {
    final uri = options?.url;
    final method = options?.method;
    logPrint('$method │ ${uri.toString()}');
  }

  void _printLine({String pre = '', String suf = '╝'}) {
    logPrint('$pre${'═' * _maxWidth}$suf');
  }

  void _commit(LogLevel level) {
    if (level.priority >= LogLevel.error.priority) {
      final valueError = _value.toString();
      final errorTitle = valueError.substring(0, valueError.indexOf('\n'));
      final errorBody = valueError.substring(errorTitle.length);
      _logger.data.log(level, errorTitle, errorBody);
    } else {
      _logger.data.log(level, _value.toString());
    }
    _value.clear();
  }

  @override
  FutureOr<Response<BodyType>> intercept<BodyType>(
      Chain<BodyType> chain) async {
    final request = chain.request;
    final base = await request.toBaseRequest();

    _printRequestHeader(base);

    if (showHeader) {
      _prettyPrintObject(request.parameters, header: 'Query Parameters');
      _prettyPrintObject(base.headers, header: 'Headers');
    }

    if (showBody) {
      if (base.method != 'GET') {
        final data = request.body as Object?;

        if (data != null) {
          if (request.multipart) {
            _prettyPrintObject(request.parts, header: 'Multipart form data');
          } else {
            _prettyPrintObject(data, header: 'Body');
          }
        }
      }
    }

    _commit(LogLevelExtension.networkRequest);

    final response = await chain.proceed(request);
    _printResponseHeader(response);

    if (showHeader) {
      _prettyPrintObject(response.headers, header: 'Headers');
    }

    if (showBody) {
      _printResponse(response);
    }

    final logLevel = response.isSuccessful
        ? LogLevelExtension.networkResponse
        : LogLevelExtension.networkResponseError;

    _commit(logLevel);

    return response;
  }
}
