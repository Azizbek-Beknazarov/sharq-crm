import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/services/club/data/model/club_model.dart';

abstract class ClubRemoteDataSource {
  Future<List<ClubModel>> getClub();

  Future<List<ClubModel>> getClubForCustomer(String customerId);

  Future<void> addClub(ClubModel newClub, String customerId);

  Future<void> deleteClub({required String customerId, required String clubID});

  Future<void> updateClub(String clubId, String customerId);

  Future<List<ClubModel>> getDateTimeOrders(DateTime dateTime);
}

class ClubRemoteDataSourceImpl implements ClubRemoteDataSource {
  CollectionReference clubReference =
      FirebaseFirestore.instance.collection('club');
  CollectionReference clubReferenceForCustomer =
      FirebaseFirestore.instance.collection('customers');

  //service page da malumotlarni ko'rsatish uchun kerak
  @override
  Future<List<ClubModel>> getClub() async {
    QuerySnapshot snapshot = await clubReference.get();
    // print(
    //     "object in club remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<ClubModel> clubModel = snapshot.docs
        .map((e) => ClubModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return Future.value(clubModel);
  }

  // customerga photostudio qo'shish uchun
  @override
  Future<void> addClub(ClubModel newClub, String customerId) async {
    return await clubReferenceForCustomer
        .doc(customerId)
        .collection('club_order')
        .doc(newClub.club_id)
        .set(newClub.toJson());
  }

  @override
  Future<List<ClubModel>> getClubForCustomer(String customerId) async {
    QuerySnapshot snapshot = await clubReferenceForCustomer
        .doc(customerId)
        .collection('club_order')
        .get();
    // print(
    //     "object in club remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<ClubModel> clubModel = await snapshot.docs
        .map((e) => ClubModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return Future.value(clubModel);
  }

  @override
  Future<void> deleteClub(
      {required String customerId, required String clubID}) async {
    return await clubReferenceForCustomer
        .doc(customerId)
        .collection('club_order')
        .doc(clubID)
        .delete();
  }

  @override
  Future<void> updateClub(String clubId, String customerId) async {
    return await clubReferenceForCustomer
        .doc(customerId)
        .collection('club_order')
        .doc(clubId)
        .update({"isPaid": true}).then((value) => print('ALL OK'));
  }

  @override
  Future<List<ClubModel>> getDateTimeOrders(DateTime dateTime) async {
    QuerySnapshot customerQuerySnapshot = await clubReferenceForCustomer.get();

    List<ClubModel> quantityList = [];
    final allCustomerIDS = customerQuerySnapshot.docs.map((doc) {
      return doc["customerId"];
    }).toList();

    for (int i = 0; i < allCustomerIDS.length; i++) {
      print(":::: for ichida docs ids: ${allCustomerIDS[i]}");
      CollectionReference _club_Ref = clubReferenceForCustomer
          .doc(allCustomerIDS[i])
          .collection('club_order');

      QuerySnapshot clubQuerySnapshot = await _club_Ref
          .where('isPaid', isEqualTo: true)
          .where('dateTimeOfWedding'.toString(), isEqualTo: dateTime.toString())
          .get();

      quantityList.addAll(clubQuerySnapshot.docs.map((doc) {
        return ClubModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList());

      print("::::quantityList: ${quantityList.toList()}");

      print(dateTime.toString());
    }

    return Future.value(quantityList);
  }
}
