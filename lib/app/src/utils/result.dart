sealed class Result<T> {
  const Result();

  /// Creates a successful [Result], completed with the specified [value].
  const factory Result.ok(T value) = Ok._;

  /// Creates an error [Result], completed with the specified [error].
  const factory Result.error(Exception error) = Error._;

  /// Added getter for successful data.
  T get data;
}

/// Subclass of Result for values
final class Ok<T> extends Result<T> {
  const Ok._(this.value);

  /// Returned value in result
  final T value;

  @override
  T get data => value;

  @override
  String toString() => 'Result<$T>.ok($value)';
}

/// Subclass of Result for errors
final class Error<T> extends Result<T> {
  const Error._(this.error);

  /// Returned error in result
  final Exception error;

  @override
  T get data => throw Exception('Tried to access data on an Error result: $error');

  @override
  String toString() => 'Result<$T>.error($error)';
}