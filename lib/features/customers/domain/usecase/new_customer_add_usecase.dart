import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

import '../repository/customer_repo.dart';

class AddNewCustomerUseCase implements UseCaseCustomer<void, CustomerModel> {
  final CustomerRepository _addNewCustomerRepo;

  AddNewCustomerUseCase(this._addNewCustomerRepo);

  @override
  Future<void> call({required CustomerModel params}) {
    return _addNewCustomerRepo.addNewCustomer(params);
  }

}

