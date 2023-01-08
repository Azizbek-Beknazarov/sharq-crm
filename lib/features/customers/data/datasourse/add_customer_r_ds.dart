import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

class AddCustomerRDS{
  final  _customerCollection =
  FirebaseFirestore.instance.collection('customers');

   Future<void> createCustomer(CustomerModel customerModel) async {
    await _customerCollection
        .doc(customerModel.id)
        .set(customerModel.toJson());
  }
}