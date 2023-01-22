import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/exception.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repository/customer_repo.dart';
import '../datasourse/add_customer_r_ds.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final CustomerRemoteDS customerRemoteDS;
  NetworkInfo info;

  CustomerRepositoryImpl({required this.info, required this.customerRemoteDS});

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
            id: customerEntity.id,
            dateOfSignUp: customerEntity.dateOfSignUp,
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
          id: customerEntity.id,
          dateOfSignUp: customerEntity.dateOfSignUp,
        );
        CustomerModel model = _convert(entity);
        final result = await customerRemoteDS.addNewCustomer(model);
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
        id: e.id,
        dateOfSignUp: e.dateOfSignUp,
      );
}
