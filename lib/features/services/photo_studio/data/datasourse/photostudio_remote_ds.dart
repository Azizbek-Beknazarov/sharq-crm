import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/services/photo_studio/data/model/photostudio_model.dart';

abstract class PhotoStudioRemoteDS {
  Future<List<PhotoStudioModel>> getPhotoStudio();
  Future< List<PhotoStudioModel>> getPhotoStudioForCustomer(String customerId);

  Future<void> addPhotoStudio(
       PhotoStudioModel newPhotoStudio, String customerId);
  Future<void> deletePhotoStudio({required String customerId,required String photostudioID});
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
    print("object in photo studio remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<PhotoStudioModel> photoStudioModel =
        snapshot.docs.map((e) => PhotoStudioModel.fromJson(e.data() as Map<String,dynamic>)).toList();
    return Future.value(photoStudioModel);
  }

  // customerga photostudio qo'shish uchun
  @override
  Future<void> addPhotoStudio(PhotoStudioModel newPhotoStudio,String customerId) async{
    return await photoReferenceForCustomer.doc(customerId).collection('photo_studio_order').doc(newPhotoStudio.photo_studio_id).set(newPhotoStudio.toJson());
  }

  @override
  Future<List<PhotoStudioModel>> getPhotoStudioForCustomer(String customerId)async {
    QuerySnapshot snapshot = await photoReferenceForCustomer.doc(customerId).collection('photo_studio_order').get();
    print("object in photo studio remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<PhotoStudioModel> photoStudioModel =
    await snapshot.docs.map((e) => PhotoStudioModel.fromJson(e.data() as Map<String,dynamic>)).toList();
    return Future.value(photoStudioModel);
  }

  @override
  Future<void> deletePhotoStudio({required String customerId, required String photostudioID}) async{

  return  await photoReferenceForCustomer.doc(customerId).collection('photo_studio_order').doc(photostudioID).delete();
  }

}
