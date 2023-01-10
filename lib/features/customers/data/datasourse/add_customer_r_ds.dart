import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

abstract class CustomerRemoteDS {
  Future<List<CustomerModel>> getAllCustomer();

  Future<void> deleteCustomer(String id);

  Future<void> updateCustomer(CustomerModel customerModel,String customerId);
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

  @override
  Future<void> deleteCustomer(String id) async {
    return await reference.doc(id).delete();
  }

  @override
  Future<void> updateCustomer(CustomerModel customerModel, String customerId ) async {

    await reference.doc(customerId).update(customerModel.toJson());
    return Future.value(customerModel);
  }
}

class AddCustomerRDS {
  final _customerCollection =
      FirebaseFirestore.instance.collection('customers');

  Future<void> createCustomer(CustomerModel customerModel) async {
    await _customerCollection.doc(customerModel.id).set(customerModel.toJson());
  }
}
