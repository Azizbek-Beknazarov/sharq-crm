import 'package:dartz/dartz.dart';

import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/network/network_info.dart';
import 'package:sharq_crm/features/auth/data/datasourse/manager_auth_lds.dart';
import 'package:sharq_crm/features/auth/data/datasourse/manager_auth_rds.dart';
import 'package:sharq_crm/features/auth/data/model/manager_model.dart';

import 'package:sharq_crm/features/auth/domain/entity/manager_entity.dart';

import '../../../../core/error/exception.dart';
import '../../domain/repository/manager_repo.dart';

typedef Future<ManagerEntity> _LoginOrRegister();

class ManagerAuthRepositoryImpl implements ManagerAuthRepository {
  final ManagerAuthRemoteDataSource remoteDataSource;
  final ManagerAuthLocalDataSource localDataSource;
  final NetworkInfo info;

  ManagerAuthRepositoryImpl(
      {required this.remoteDataSource,
      required this.localDataSource,
      required this.info});

  @override
  Future<Either<Failure, ManagerEntity>> getCurrentManager()async {
    try {
      final currentManager = await localDataSource.getCurrentManager();
      return Right(currentManager);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerEntity>> loginManager(
      {required Map authData}) async{
    return await _loginOrRegister(() => remoteDataSource.loginManager(authData: authData));
  }

  @override
  Future<Either<Failure, bool>> logout() async{
    try {
      await localDataSource.logOutManager();
      await remoteDataSource.logOutManager();
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }

  @override
  Future<Either<Failure, ManagerEntity>> registerManager(
      {required Map authData}) async{
    return await _loginOrRegister(() => remoteDataSource.registerManager(authData: authData));
  }

  Future<Either<Failure, ManagerEntity>> _loginOrRegister(
      _LoginOrRegister loginOrRegister,
      ) async {
    if (await info.isConnected) {
      try {
        final manager = await loginOrRegister();

        final managerModel = ManagerModel(
          id: manager.id,
          name: manager.name,
          email: manager.email,
        );

        localDataSource.saveManager(managerModel);
        return Right(manager);
      } on ServerException {
        return Left(ServerFailure());
      } on CanceledByUserException {
        return Left(CanceledByUserFailure());
      } on FirebaseDataException catch (error) {
        return Left(FirebaseDataFailure(error.message));
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}
