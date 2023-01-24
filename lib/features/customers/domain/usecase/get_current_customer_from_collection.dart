import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';
import '../entity/customer_entity.dart';
import '../repository/customer_repo.dart';

class GetCurrentCustomerFromCollectionUsecase extends UseCase<CustomerEntity, CustomerFromCollectionParam> {
  final CustomerRepository repository;

  GetCurrentCustomerFromCollectionUsecase(this.repository);

  @override
  Future<Either<Failure, CustomerEntity>> call(CustomerFromCollectionParam params) async {
    return await repository.getCurrentCustomerFromCollection(params.customerID);
  }
}