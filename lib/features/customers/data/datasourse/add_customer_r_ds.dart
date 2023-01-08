import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

abstract class CustomerRemoteDS {
  Future<List<CustomerModel>> getAllCustomer();
}

class CustomerRemoteDSImpl implements CustomerRemoteDS {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('customers');

  @override
  Future<List<CustomerModel>> getAllCustomer() async {
    QuerySnapshot snapshot = await reference.get();

    var customer = snapshot.docs
        .map((e) =>
            CustomerModel(name: e['name'], phone: e['phone'], id: e['id']))
        .toList();

    return Future.value(customer);
  }

}

class AddCustomerRDS {
  final _customerCollection =
      FirebaseFirestore.instance.collection('customers');

  Future<void> createCustomer(CustomerModel customerModel) async {
    await _customerCollection.doc(customerModel.id).set(customerModel.toJson());
  }
}
