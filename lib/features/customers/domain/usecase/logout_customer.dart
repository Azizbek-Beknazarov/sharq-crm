import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/customers/domain/repository/customer_repo.dart';

class LogOutCustomerUseCase extends UseCase<bool, NoParams> {
  final CustomerRepository repository;

  LogOutCustomerUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.logOutCuctomer();
  }
}
