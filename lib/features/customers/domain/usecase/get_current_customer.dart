import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/customers/domain/repository/customer_repo.dart';

import '../../../../core/usecase/usecase.dart';

class GetCurrentCustomerUsecase extends UseCase<CustomerEntity, NoParams> {
  final CustomerRepository repository;

  GetCurrentCustomerUsecase(this.repository);

  @override
  Future<Either<Failure, CustomerEntity>> call(NoParams params) async{
    return  await repository.getCurrentCustomer();
  }





}