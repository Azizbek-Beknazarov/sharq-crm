import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/services/album/data/model/album_model.dart';

abstract class AlbumRemoteDataSource {
  Future<List<AlbumModel>> getAlbum();

  Future<List<AlbumModel>> getAlbumForCustomer(String customerId);

  Future<void> addAlbum(AlbumModel newAlbum, String customerId);

  Future<void> deleteAlbum(
      {required String customerId, required String albumID});
}

class AlbumRemoteDataSourceImpl implements AlbumRemoteDataSource {
  CollectionReference albumReference =
      FirebaseFirestore.instance.collection('album');
  CollectionReference albumReferenceForCustomer =
      FirebaseFirestore.instance.collection('customers');

  @override
  Future<void> addAlbum(AlbumModel newAlbum, String customerId) async {
    return await albumReferenceForCustomer
        .doc(customerId)
        .collection('album_order')
        .doc(newAlbum.album_id)
        .set(newAlbum.toJson());
  }

  @override
  Future<void> deleteAlbum(
      {required String customerId, required String albumID}) async {
    return await albumReferenceForCustomer
        .doc(customerId)
        .collection('album_order')
        .doc(albumID)
        .delete();
  }

  @override
  Future<List<AlbumModel>> getAlbum() async {
    QuerySnapshot snapshot = await albumReference.get();
    // print(
    //     "object in album remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<AlbumModel> albumModel = snapshot.docs
        .map((e) => AlbumModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return Future.value(albumModel);
  }

  @override
  Future<List<AlbumModel>> getAlbumForCustomer(String customerId) async {
    QuerySnapshot snapshot = await albumReferenceForCustomer
        .doc(customerId)
        .collection('album_order')
        .get();
    // print(
    //     "object in album remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<AlbumModel> albumModel = await snapshot.docs
        .map((e) => AlbumModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return Future.value(albumModel);
  }
}
