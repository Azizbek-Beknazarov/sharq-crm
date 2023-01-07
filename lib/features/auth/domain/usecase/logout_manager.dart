import 'package:dartz/dartz.dart';
import 'package:sharq_crm/features/auth/domain/repository/manager_repo.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class LogoutManager extends UseCase<bool, NoParams> {
  final ManagerAuthRepository repository;

  LogoutManager(this.repository);

  @override
  Future<Either<Failure, bool>> call(NoParams params) async {
    return await repository.logout();
  }
}
