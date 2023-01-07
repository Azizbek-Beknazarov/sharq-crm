import 'package:dartz/dartz.dart';
import 'package:sharq_crm/features/auth/domain/entity/manager_entity.dart';
import 'package:sharq_crm/features/auth/domain/repository/manager_repo.dart';

import '../../../../core/error/failures.dart';
import '../../../../core/usecase/usecase.dart';

class GetCurrentManager extends UseCase<ManagerEntity, NoParams> {
  final ManagerAuthRepository repository;

  GetCurrentManager(this.repository);

  @override
  Future<Either<Failure, ManagerEntity>> call(NoParams params) async {
    return await repository.getCurrentManager();
  }
}
