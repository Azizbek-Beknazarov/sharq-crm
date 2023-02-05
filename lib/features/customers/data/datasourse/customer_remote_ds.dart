import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

import '../../../../core/error/exception.dart';

abstract class CustomerRemoteDS {
  Future<List<CustomerModel>> getAllCustomer();

  Future<void> deleteCustomer(String id);

  Future<void> updateCustomer(CustomerModel customerModel, String customerId);

  Future<void> addNewCustomer(CustomerModel customerModel);
  Future<CustomerModel> getCurrentCustomerFromCollection(String customerID);
  Future<bool> logOutCustomer();




// Future<List<CustomerModel>> searchCustomer(String query);
}

class CustomerRemoteDSImpl implements CustomerRemoteDS {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('customers');
  FirebaseAuth _auth=FirebaseAuth.instance;


  @override
  Future<List<CustomerModel>> getAllCustomer() async {
    QuerySnapshot snapshot = await reference.get();

    print("object::  ${snapshot.docs.map((e) => e.data()).toList()}");
    List<CustomerModel> customers = snapshot.docs
        .map((e) => CustomerModel.fromJson(e.data() as Map<String, dynamic>))
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
    print("customer model id: ${customerModel.customerId.toString()}");
    print("customerId: ${customerId.toString()}");
    await reference.doc(customerId).update(customerModel.toJson());
    return Future.value(customerModel);
  }

  @override
  Future<void> addNewCustomer(CustomerModel customerModel) async {


    await reference.doc(customerModel.customerId).set(customerModel.toJson());
    return Future.value(customerModel);
  }

  @override
  Future<CustomerModel> getCurrentCustomerFromCollection(String customerID) async{
    DocumentSnapshot snapshot = await reference.doc(customerID).get();

    CustomerModel model=CustomerModel.fromJson(snapshot.data() as Map<String,dynamic>);

    return Future.value(model);
  }

  @override
  Future<bool> logOutCustomer() async{
    try {
      await _auth.signOut();
      print("log out buldi customer remote ds ichida");

      return true;
    } catch (e) {
      throw (OfflineException);
    }
  }


}
