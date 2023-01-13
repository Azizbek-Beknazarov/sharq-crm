import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';

import 'package:sharq_crm/features/customers/domain/repository/customer_repo.dart';

class UpdateCustomerUseCase extends UseCaseUpdate<void,CustomerUpdateParams >{
   CustomerRepository repository;

  UpdateCustomerUseCase({required this.repository});

  @override
  Future<Either<Failure, void>> call(CustomerUpdateParams params) async{
  return await repository.updateCuctomers(params.customerEntity, params.id);
  }



}