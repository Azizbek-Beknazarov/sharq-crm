import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

abstract class CustomerRemoteDS {
  Future<List<CustomerModel>> getAllCustomer();

  Future<void> deleteCustomer(String id);

  Future<void> updateCustomer(CustomerModel customerModel, String customerId);

  Future<void> addNewCustomer(CustomerModel customerModel);

// Future<List<CustomerModel>> searchCustomer(String query);
}

class CustomerRemoteDSImpl implements CustomerRemoteDS {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('customers');

  @override
  Future<List<CustomerModel>> getAllCustomer() async {
    QuerySnapshot snapshot = await reference.get();

    List<CustomerModel> customers = snapshot.docs
        .map((e) => CustomerModel(
            name: e['name'],
            phone: e['phone'],
            id: e['id'],
            dateOfSignUp: e['dateOfSignUp']))
        .toList();

    return Future.value(customers);
  }

  @override
  Future<void> deleteCustomer(String id) async {
    return await reference.doc(id).delete();
  }

  @override
  Future<void> updateCustomer(
      CustomerModel customerModel, String customerId) async {
    await reference.doc(customerId).update(customerModel.toJson());
    return Future.value(customerModel);
  }

  @override
  Future<void> addNewCustomer(CustomerModel customerModel) async{
   await reference.doc(customerModel.id).set(customerModel.toJson());
   return Future.value(customerModel);
  }
}

