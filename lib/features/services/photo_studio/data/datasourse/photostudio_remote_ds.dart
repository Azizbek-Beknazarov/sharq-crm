import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/services/photo_studio/data/model/photostudio_model.dart';

abstract class PhotoStudioRemoteDS {
  Future<List<PhotoStudioModel>> getPhotoStudio();
}

class PhotoStudioRemoteDSImpl implements PhotoStudioRemoteDS {
  CollectionReference reference =
      FirebaseFirestore.instance.collection('photo_studio');

  @override
  Future<List<PhotoStudioModel>> getPhotoStudio() async {
    QuerySnapshot snapshot = await reference.get();
    List<PhotoStudioModel> photoStudioModel =
        snapshot.docs.map((e) => PhotoStudioModel(photo_studio_id: e['photo_studio_id'], price: e['price'])).toList();
    return Future.value(photoStudioModel);
  }
}
