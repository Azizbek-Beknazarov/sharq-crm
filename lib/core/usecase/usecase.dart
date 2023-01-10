import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}
abstract class UseCaseUpdate<Type, Params, String> {
  Future<Either<Failure, Type>> call(Params params, String id);
}

class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

abstract class UseCaseCustomer<R, P> {
  Future<R> call({required P params});
}

