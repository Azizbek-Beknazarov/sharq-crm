import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/customers/domain/repository/customer_repo.dart';

class CustomerDeleteUseCase extends UseCase<void, String> {
  final CustomerRepository customerRepository;

  CustomerDeleteUseCase({required this.customerRepository});

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await customerRepository.deleteCuctomers(id);
  }
}
