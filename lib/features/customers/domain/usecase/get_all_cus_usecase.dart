import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:sharq_crm/features/customers/domain/repository/customer_repo.dart';

class GetAllCustomersUseCase extends UseCase<List<CustomerModel>, NoParams> {
  final CustomerRepository customerRepository;

  GetAllCustomersUseCase(this.customerRepository);

  @override
  Future<Either<Failure, List<CustomerModel>>> call(NoParams params)async {
    return await customerRepository.getAllCuctomers();
  }



 

}
