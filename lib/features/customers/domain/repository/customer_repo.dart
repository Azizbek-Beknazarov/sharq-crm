import 'package:dartz/dartz.dart';

import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';

import '../../../../core/error/failures.dart';

abstract class CustomerRepository {
  Future<Either<Failure, void>> addNewCustomer(CustomerEntity customerEntity);

  Future<Either<Failure, List<CustomerEntity>>> getAllCuctomers();

  Future<Either<Failure, void>> deleteCuctomers(String id);

  Future<Either<Failure, void>> updateCuctomers(
      CustomerEntity customerEntity, String customerId);

  Future<Either<Failure, CustomerEntity>> getCurrentCustomer();
  Future<Either<Failure, CustomerEntity>> getCurrentCustomerFromCollection(String customerID);
  // Future<Either<Failure, List<CustomerModel>>> searchCuctomers(String query);
}
