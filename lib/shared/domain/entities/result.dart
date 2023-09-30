import 'failure.dart';

class Result<T> {
  final T? _data;
  final T? _cachedData;
  final Failure? _failure;

  const Result._(this._data, this._failure, [this._cachedData]);
  factory Result.success(T data) => Result._(data, null);
  factory Result.failure(Failure failure, [T? cachedData]) => Result._(null, failure, cachedData);
  static Result<VoidSuccess> voidSuccess() => Result._(VoidSuccess(), null);

  T get data => _data!;
  T? get cachedData => _cachedData;
  Failure get failure => _failure!;

  bool get isSuccess => _data != null;

  void when({
    required void Function(T data) onSuccess,
    void Function(Failure failure, T? cachedData)? onFailure,
  }) {
    if (isSuccess) {
      onSuccess(data);
    } else {
      onFailure?.call(failure, cachedData);
    }
  }
}

class VoidSuccess {}
