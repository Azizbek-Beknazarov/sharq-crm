import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/services/photo_studio/data/model/photostudio_model.dart';

abstract class PhotoStudioRemoteDS {
  Future<List<PhotoStudioModel>> getPhotoStudio();

  Future<List<PhotoStudioModel>> getPhotoStudioForCustomer(String customerId);

  Future<void> addPhotoStudio(
      PhotoStudioModel newPhotoStudio, String customerId);

  Future<void> deletePhotoStudio(
      {required String customerId, required String photostudioID});

  Future<void> updatePhotoStudio(String photostudioId, String customerId);

  Future<List<PhotoStudioModel>> getDateTimeOrders(DateTime dateTime);
}

class PhotoStudioRemoteDSImpl implements PhotoStudioRemoteDS {
  CollectionReference photoReference =
      FirebaseFirestore.instance.collection('photo_studio');
  CollectionReference photoReferenceForCustomer =
      FirebaseFirestore.instance.collection('customers');

  //service page da malumotlarni ko'rsatish uchun kerak
  @override
  Future<List<PhotoStudioModel>> getPhotoStudio() async {
    QuerySnapshot snapshot = await photoReference.get();
    // print(
    //     "object in photo studio remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<PhotoStudioModel> photoStudioModel = snapshot.docs
        .map((e) => PhotoStudioModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return Future.value(photoStudioModel);
  }

  // customerga photostudio qo'shish uchun
  @override
  Future<void> addPhotoStudio(
      PhotoStudioModel newPhotoStudio, String customerId) async {
    return await photoReferenceForCustomer
        .doc(customerId)
        .collection('photo_studio_order')
        .doc(newPhotoStudio.photo_studio_id)
        .set(newPhotoStudio.toJson());
  }

  @override
  Future<List<PhotoStudioModel>> getPhotoStudioForCustomer(
      String customerId) async {
    QuerySnapshot snapshot = await photoReferenceForCustomer
        .doc(customerId)
        .collection('photo_studio_order')
        .get();
    // print(
    //     "object in photo studio remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<PhotoStudioModel> photoStudioModel = await snapshot.docs
        .map((e) => PhotoStudioModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return Future.value(photoStudioModel);
  }

  @override
  Future<void> deletePhotoStudio(
      {required String customerId, required String photostudioID}) async {
    return await photoReferenceForCustomer
        .doc(customerId)
        .collection('photo_studio_order')
        .doc(photostudioID)
        .delete();
  }

  @override
  Future<void> updatePhotoStudio(
      String photostudioId, String customerId) async {
    return await photoReferenceForCustomer
        .doc(customerId)
        .collection('photo_studio_order')
        .doc(photostudioId)
        .update({"isPaid": true}).then((value) => print('ALL OK'));
  }

  @override
  Future<List<PhotoStudioModel>> getDateTimeOrders(DateTime dateTime)async {
    QuerySnapshot customerQuerySnapshot = await photoReferenceForCustomer.get();
    // int quantity = 0;
    List<PhotoStudioModel> quantityList=[];
    final allCustomerIDS = customerQuerySnapshot.docs.map((doc) {
      return doc["customerId"];
    }).toList();

    for (int i = 0; i < allCustomerIDS.length; i++) {
      print(":::: for ichida docs ids: ${allCustomerIDS[i]}");
      CollectionReference _photo_Ref =
      photoReferenceForCustomer.doc(allCustomerIDS[i]).collection('photo_studio_order');

      QuerySnapshot  photoQuerySnapshot=await _photo_Ref
          .where('isPaid', isEqualTo: true)
      .where('dateTimeOfWedding'.toString(), isEqualTo: dateTime.toString())
          .get();

      // final allDataPhotoDateTime = photoQuerySnapshot.docs.map((doc) {
      //   return doc["dateTimeOfWedding"];
      // }).toList();
       quantityList.addAll( photoQuerySnapshot.docs.map((doc) {
         return PhotoStudioModel.fromJson(doc.data() as Map<String, dynamic>);
       }).toList());


      // for(int j=0;j<photoQuerySnapshot.docs.length;j++){
      //   if(dateTime.toString()==photoQuerySnapshot.docs[j].toString()){
      //     quantity++;
      //     quantityList=await  photoQuerySnapshot.docs
      //         .map((e) => PhotoStudioModel.fromJson(e.data() as Map<String, dynamic>))
      //         .toList();
      //
      //     // print("::::quantityList: ${quantityList.toList()}");
      //   }
      // }
      print("::::quantityList: ${quantityList.toList()}");

      // for (int j = 0; j < allDataPhotoDateTime.length; j++) {
      //   print("::::allDataPhotoDateTime: ${allDataPhotoDateTime[j]}");
      //   if(dateTime.toString()==allDataPhotoDateTime[j].toString()){
      //     quantity++;
      //
      //
      //     quantityList=await  photoQuerySnapshot.docs
      //         .map((e) => PhotoStudioModel.fromJson(e.data() as Map<String, dynamic>))
      //         .toList();
      //
      //
      //     print("::::quantityList: ${quantityList.toList()}");
      //   }
      // }

      //
      // for (int j = 0; j < allDataPhotoDateTime.length; j++) {
      //   print("::::allDataPhotoDateTime: ${allDataPhotoDateTime[j]}");
      //   if(dateTime.toString()==allDataPhotoDateTime[j].toString()){
      //     quantity++;
      //     quantityList=await  photoQuerySnapshot.docs
      //         .map((e) => PhotoStudioModel.fromJson(e.data() as Map<String, dynamic>))
      //         .toList();
      //     print("::::quantityList: ${quantityList.toList()}");
      //   }
      // }

      print(dateTime.toString());
      // print("::::quantity: ${quantity.toString()}");
    }

    // print("::::quantity ALOHIDA: ${quantity.toString()}");
    return Future.value(quantityList) ;
  }
}
