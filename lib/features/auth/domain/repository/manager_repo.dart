import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/features/auth/domain/entity/manager_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ManagerAuthRepository {
  Future<Either<Failure, ManagerEntity>> loginManager({required Map authData});
  Future<Either<Failure, ManagerEntity>> registerManager({required Map authData});
  Future<Either<Failure, ManagerEntity>> getCurrentManager();
  Future<Either<Failure, bool>> logout();
}