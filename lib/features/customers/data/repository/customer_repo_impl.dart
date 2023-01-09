import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/exception.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/repository/customer_repo.dart';
import '../datasourse/add_customer_r_ds.dart';

class CustomerRepositoryImpl implements CustomerRepository {
  final AddCustomerRDS remodeDS;
  final CustomerRemoteDS customerRemoteDS;
  NetworkInfo info;

  CustomerRepositoryImpl(
      {required this.remodeDS,
      required this.info,
      required this.customerRemoteDS});

  @override
  Future<void> addNewCustomer(CustomerModel customerModel) async {
    if (await info.isConnected) {
      try {
        await remodeDS.createCustomer(customerModel);
      } catch (e) {
        return Future.error(e.toString());
      }
    }
  }

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

  @override
  Future<Either<Failure, void>> deleteCuctomers(String id)async {
  if(await info.isConnected){
    final result=await customerRemoteDS.deleteCustomer(id);
    return Right(result);
  }else return Left(ServerFailure());
  }
}
