import 'dart:developer';

import 'package:chopper/chopper.dart';
import 'package:data/data_layer.dart';

final jsonDecoderMappings = <Map<Object, _JsonFactory<Object?>>>[
  {
    ProfileDto: ProfileDto.fromJson,
    AuthResponseDto:AuthResponseDto.fromJson,
  },
];

class JsonSerializableConverter extends JsonConverter {
  final jsonDecoder = CustomJsonDecoder(jsonDecoderMappings);
  static final instance = JsonSerializableConverter._();

  JsonSerializableConverter._();

  @override
  Future<Response<ResultType>> convertResponse<ResultType, Item>(
    Response<dynamic> response,
  )async {
    if (response.bodyString.isEmpty) {
      return Response(response.base, null, error: response.error);
    }

    final jsonRes  = await super.convertResponse<Object, Item>(response);

    return jsonRes.copyWith<ResultType>(
      body: jsonDecoder.decode<Item>(jsonRes.body) as ResultType,
    );
  }
}

typedef _JsonFactory<T> = T Function(Map<String, dynamic> json);

class CustomJsonDecoder {
  final List<Map<Object, _JsonFactory<Object?>>> fromJson;

  const CustomJsonDecoder(this.fromJson);

  dynamic decode<T>(Object? entity) {
    if (entity is Iterable) {
      return _decodeList<T>(entity);
    }
    if (entity is T) {
      return entity;
    }
    if (entity is Map<String, dynamic>) {
      return _decodeMap<T>(entity);
    }

    return entity;
  }

  T _decodeMap<T>(Map<String, dynamic> values) {
    final jsonFactory = _getFromJson<T>();
    try {
      return jsonFactory(values);
    } catch (ex) {
      log(ex.toString());

      rethrow;
    }
  }

  _JsonFactory<T> _getFromJson<T>() {
    for (final list in fromJson) {
      if (list[T] != null) {
        return list[T]! as _JsonFactory<T>;
      }
    }

    return throw Exception(
      "Could not find factory for type $T. Is '$T: $T.fromJsonFactory' included in the CustomJsonDecoder instance creation in bootstrapper.dart?",
    );
  }

  List<T> _decodeList<T>(Iterable<Object?> values) =>
      values.where((v) => v != null).map<T>((v) => decode<T>(v) as T).toList();
}
