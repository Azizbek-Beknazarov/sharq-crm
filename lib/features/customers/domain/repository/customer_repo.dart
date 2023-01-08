import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

abstract class CustomerRepository{
  Future<void> addNewCustomer(CustomerModel customerModel);
}