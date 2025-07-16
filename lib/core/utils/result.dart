abstract class Result<S extends Object, F extends Object> {
  S? get result;
  F? get failure;

  Result();

  factory Result.success(S result) => Success(result);

  factory Result.failure(F failure) => Failure(failure);
}

final class Success<S extends Object, F extends Object> extends Result<S, F> {
  @override
  final S result;
  @override
  Null get failure => null;

  Success(this.result);
}

final class Failure<S extends Object, F extends Object> extends Result<S, F> {
  @override
  Null get result => null;
  @override
  final F failure;

  Failure(this.failure);
}