import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

import 'package:sharq_crm/features/customers/domain/repository/customer_repo.dart';

class GetAllCustomersUseCase extends UseCase<List<CustomerEntity>, NoParams> {
  final CustomerRepository customerRepository;

  GetAllCustomersUseCase(this.customerRepository);

  @override
  Future<Either<Failure, List<CustomerEntity>>> call(NoParams params)async {
    return await customerRepository.getAllCuctomers();
  }



 

}
