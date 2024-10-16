import 'package:freezed_annotation/freezed_annotation.dart';

part 'result.freezed.dart';

@freezed
class Result<T, E extends Exception> with _$Result<T, E> {
  const Result._();

  const factory Result.success(T data) = _Success;
  const factory Result.failure(E error) = _Failure;

  bool get isSuccess => this is _Success;
  bool get isFailed => this is _Failure;

  T get success => (this as _Success).data as T;
  E get failure => (this as _Failure).error as E;
}
