import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/services/album/data/model/album_model.dart';

abstract class AlbumRemoteDataSource {
  Future<List<AlbumModel>> getAlbum();

  Future<List<AlbumModel>> getAlbumForCustomer(String customerId);

  Future<void> addAlbum(AlbumModel newAlbum, String customerId);

  Future<void> deleteAlbum(
      {required String customerId, required String albumID});
  Future<void> updateAlbum(String albumId, String customerId);
  Future<List<AlbumModel>> getDateTimeOrders(DateTime dateTime);
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

  @override
  Future<void> updateAlbum(String albumId, String customerId) async{
    return await albumReferenceForCustomer
        .doc(customerId)
        .collection('album_order')
        .doc(albumId)
        .update({"isPaid": true}).then((value) => print('ALL OK'));
  }

  @override
  Future<List<AlbumModel>> getDateTimeOrders(DateTime dateTime)async {
    QuerySnapshot customerQuerySnapshot = await albumReferenceForCustomer.get();

    List<AlbumModel> quantityList=[];
    final allCustomerIDS = customerQuerySnapshot.docs.map((doc) {
      return doc["customerId"];
    }).toList();

    for (int i = 0; i < allCustomerIDS.length; i++) {
      print(":::: for ichida docs ids: ${allCustomerIDS[i]}");
      CollectionReference _album_Ref =
      albumReferenceForCustomer.doc(allCustomerIDS[i]).collection('album_order');

      QuerySnapshot  albumQuerySnapshot=await _album_Ref
          .where('isPaid', isEqualTo: true)
          .where('dateTimeOfWedding'.toString(), isEqualTo: dateTime.toString())
          .get();

      quantityList.addAll( albumQuerySnapshot.docs.map((doc) {
        return AlbumModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList());

      print("::::quantityList: ${quantityList.toList()}");


      print(dateTime.toString());

    }

    return Future.value(quantityList) ;
  }
}


