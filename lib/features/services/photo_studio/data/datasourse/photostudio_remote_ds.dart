import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/services/photo_studio/data/model/photostudio_model.dart';

abstract class PhotoStudioRemoteDS {
  Future<List<PhotoStudioModel>> getPhotoStudio();

  Future<void> addPhotoStudio(
       PhotoStudioModel newPhotoStudio);
}

class PhotoStudioRemoteDSImpl implements PhotoStudioRemoteDS {
  CollectionReference photoReference =
      FirebaseFirestore.instance.collection('photo_studio');

  @override
  Future<List<PhotoStudioModel>> getPhotoStudio() async {
    QuerySnapshot snapshot = await photoReference.get();
    print("object in photo studio remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<PhotoStudioModel> photoStudioModel =
        snapshot.docs.map((e) => PhotoStudioModel.fromJson(e.data() as Map<String,dynamic>)).toList();
    return Future.value(photoStudioModel);
  }

  @override
  Future<void> addPhotoStudio(PhotoStudioModel newPhotoStudio) async{
    return await photoReference.doc(newPhotoStudio.photo_studio_id).set(newPhotoStudio.toJson());
  }

}
