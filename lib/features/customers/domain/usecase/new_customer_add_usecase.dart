import 'package:sharq_crm/core/usecase/usecase.dart';


import '../entity/customer_entity.dart';
import '../repository/customer_repo.dart';

class AddNewCustomerUseCase implements UseCaseCustomer<void, CustomerEntity> {
  final CustomerRepository _addNewCustomerRepo;

  AddNewCustomerUseCase(this._addNewCustomerRepo);

  @override
  Future<void> call({required CustomerEntity params}) {
    return _addNewCustomerRepo.addNewCustomer(params);
  }

}

