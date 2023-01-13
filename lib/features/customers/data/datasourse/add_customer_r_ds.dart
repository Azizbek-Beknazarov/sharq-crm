import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:sharq_crm/features/customers/data/model/customer_model.dart';

abstract class CustomerRemoteDS {
  Future<List<CustomerModel>> getAllCustomer();

  Future<void> deleteCustomer(String id);

  Future<void> updateCustomer(CustomerModel customerModel,String customerId);

  // Future<List<CustomerModel>> searchCustomer(String query);
}

class CustomerRemoteDSImpl implements CustomerRemoteDS {
  CollectionReference reference =
  FirebaseFirestore.instance.collection('customers');

  @override
  Future<List<CustomerModel>> getAllCustomer() async {
    QuerySnapshot snapshot = await reference.get();

    List<CustomerModel> customers =

    snapshot.docs
        .map((e) =>
        CustomerModel(name: e['name'], phone: e['phone'], id: e['id'], dateOfSignUp: e['dateOfSignUp']))
        .toList();

    return Future.value(customers);
  }

  @override
  Future<void> deleteCustomer(String id) async {
    return await reference.doc(id).delete();
  }

  @override
  Future<void> updateCustomer(CustomerModel customerModel,
      String customerId) async {
    await reference.doc(customerId).update(customerModel.toJson());
    return Future.value(customerModel);
  }}

//   @override
//   Future<List<CustomerModel>> searchCustomer(String query) {
//
//     // StreamBuilder(
//     //     stream: ( searchtxt!= "" && searchtxt!= null)?FirebaseFirestore
//     //         .instance.collection("addjop")
//     //         .where("specilization",isNotEqualTo:searchtxt)
//     //         .orderBy("specilization")
//     //         .startAt([searchtxt,])
//     //         .endAt([searchtxt+'\uf8ff',])
//     //         .snapshots()
//     //         :FirebaseFirestore.instance.collection("addjop").snapshots(),
//     //
//     //
//     //     builder:(BuildContext context,snapshot) {
//     //       if (snapshot.connectionState == ConnectionState.waiting &&
//     //           snapshot.hasData != true) {
//     //         return Center(
//     //           child:CircularProgressIndicator(),
//     //         );
//     //       }
//     //       else
//     //       {retun widget();
//     //       }
//     //     })
//
//
//     // return Future.value(cu)
//   }
// }


//
  class AddCustomerRDS {
  final _customerCollection =
  FirebaseFirestore.instance.collection('customers');

  Future<void> createCustomer(CustomerModel customerModel) async {
  await _customerCollection.doc(customerModel.id).set(customerModel.toJson());
  }
  }
