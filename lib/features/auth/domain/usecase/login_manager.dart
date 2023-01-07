import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/auth/domain/entity/manager_entity.dart';

import '../repository/manager_repo.dart';

class LoginManager extends UseCase<ManagerEntity, Map> {
  final ManagerAuthRepository repository;

  LoginManager(this.repository);

  @override
  Future<Either<Failure, ManagerEntity>> call(Map authData) async {
    return await repository.loginManager(authData: authData);
  }
}
