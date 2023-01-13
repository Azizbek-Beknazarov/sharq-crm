import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';

import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseUpdate<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseCustomer<R, P> {
  Future<R> call({required P params});
}

abstract class UseCaseCar<T, P> {
  Future<T> call({required P params});
}

abstract class Mapper<FROM, TO> {
  TO call(FROM object);
}

//Params
//1
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

//2
class CarParams extends Equatable {
  final CarEntity carParam;
  final String customerID;

  CarParams(this.carParam, this.customerID);

  @override
  List<Object?> get props => [carParam, customerID];
}

//3
class CustomerUpdateParams extends Equatable {
  CustomerEntity customerEntity;
  String id;

  CustomerUpdateParams(this.customerEntity, this.id);

  @override
  List<Object?> get props => [customerEntity, id];
}
