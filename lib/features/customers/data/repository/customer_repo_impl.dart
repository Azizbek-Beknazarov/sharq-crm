import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/exception.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/features/customers/data/datasourse/customer_local_datasource.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repository/customer_repo.dart';
import '../datasourse/customer_remote_ds.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDS customerRemoteDS;
  final CustomerLocalDataSource localDataSource;
  NetworkInfo info;

  CustomerRepositoryImpl({required this.info, required this.customerRemoteDS,required this.localDataSource});

  //
  @override
  Future<Either<Failure, List<CustomerModel>>> getAllCuctomers() async {
    if (await info.isConnected) {
      try {
        final remoteC = await customerRemoteDS.getAllCustomer();
        return Right(remoteC);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  //
  @override
  Future<Either<Failure, void>> deleteCuctomers(String id) async {
    if (await info.isConnected) {
      final result = await customerRemoteDS.deleteCustomer(id);
      return Right(result);
    } else
      return Left(ServerFailure());
  }

  //

  @override
  Future<Either<Failure, void>> updateCuctomers(
      CustomerEntity customerEntity, String customerId) async {
    if (await info.isConnected) {
      try {
        CustomerEntity entity = CustomerModel(
          name: customerEntity.name,
          phone: customerEntity.phone,
          customerId: customerEntity.customerId,
          dateOfSignUp: customerEntity.dateOfSignUp,
          managerAdded: customerEntity.managerAdded,
        );
        CustomerModel model = _convert(entity);
        final result = await customerRemoteDS.updateCustomer(model, customerId);
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addNewCustomer(
      CustomerEntity customerEntity) async {
    if (await info.isConnected) {
      try {
        CustomerEntity entity = CustomerModel(
            name: customerEntity.name,
            phone: customerEntity.phone,
            customerId: customerEntity.customerId,
            dateOfSignUp: customerEntity.dateOfSignUp,
            managerAdded: customerEntity.managerAdded);
        CustomerModel model = _convert(entity);
        final result = await customerRemoteDS.addNewCustomer(model);
        await localDataSource.saveCustomer(model);
        print("localga saqlandi ${customerEntity.name}");
        return Right(result);
      } catch (e) {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  final _convert = (CustomerEntity e) => CustomerModel(
        name: e.name,
        phone: e.phone,
        customerId: e.customerId,
        dateOfSignUp: e.dateOfSignUp,
        managerAdded: e.managerAdded,
      );

  @override
  Future<Either<Failure, CustomerEntity>> getCurrentCustomer() async{
    try {
      final current = await localDataSource.getCurrentCustomer();
      print("current customer olindi repo ichida");
      return Right(current);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, CustomerEntity>> getCurrentCustomerFromCollection(String customerID) async{
    if (await info.isConnected) {
      try {
        final remoteC = await customerRemoteDS.getCurrentCustomerFromCollection(customerID);
        return Right(remoteC);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> logOutCuctomer() async{
    try {
      await localDataSource.logOutCustomer();
      await customerRemoteDS.logOutCustomer();
      return Right(true);
    } on CacheException {
      return Left(CacheFailure());
    } on OfflineException {
      return Left(OfflineFailure());
    }
  }


}
