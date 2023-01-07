import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/auth/domain/entity/manager_entity.dart';
import 'package:sharq_crm/features/auth/domain/repository/manager_repo.dart';

class RegisterManager extends UseCase<ManagerEntity, Map> {
  final ManagerAuthRepository repository;

  RegisterManager(this.repository);

  @override
  Future<Either<Failure, ManagerEntity>> call(Map authData) async {
    return await repository.registerManager(authData: authData);
  }
}