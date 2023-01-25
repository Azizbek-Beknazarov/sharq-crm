import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';


import '../../../../core/error/failures.dart';
import '../entity/customer_entity.dart';
import '../repository/customer_repo.dart';

class AddNewCustomerUseCase implements UseCaseOne<void, CustomerEntity> {
  final CustomerRepository _addNewCustomerRepo;

  AddNewCustomerUseCase(this._addNewCustomerRepo);

  @override
  Future<Either<Failure, void>> call({required CustomerEntity params}) {
    return _addNewCustomerRepo.addNewCustomer(params);
  }

}

