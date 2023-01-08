import 'package:dartz/dartz.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

import '../../../../core/error/failures.dart';

abstract class CustomerRepository{
  Future<void> addNewCustomer(CustomerModel customerModel);

  Future<Either<Failure, List<CustomerModel>>> getAllCuctomers();
}