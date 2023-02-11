import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/services/video/data/model/video_model.dart';

abstract class VideoRemoteDataSource {
  Future<List<VideoModel>> getVideo();

  Future<List<VideoModel>> getVideoForCustomer(String customerId);

  Future<void> addVideo(VideoModel newVideo, String customerId);

  Future<void> deleteVideo(
      {required String customerId, required String videoID});

  Future<void> updateVideo(String videoId, String customerId);
  Future<List<VideoModel>> getDateTimeOrders(DateTime dateTime);


}

class VideoRemoteDataSourceImpl implements VideoRemoteDataSource {
  CollectionReference videoReference =
      FirebaseFirestore.instance.collection('video');
  CollectionReference videoReferenceForCustomer =
      FirebaseFirestore.instance.collection('customers');

  @override
  Future<void> addVideo(VideoModel newVideo, String customerId) async {
    return await videoReferenceForCustomer
        .doc(customerId)
        .collection('video_order')
        .doc(newVideo.video_id)
        .set(newVideo.toJson());
  }

  @override
  Future<void> deleteVideo(
      {required String customerId, required String videoID}) async {
    return await videoReferenceForCustomer
        .doc(customerId)
        .collection('video_order')
        .doc(videoID)
        .delete();
  }

  @override
  Future<List<VideoModel>> getVideo() async {
    QuerySnapshot snapshot = await videoReference.get();
    // print(
    //     "object in Video remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<VideoModel> videoModel = snapshot.docs
        .map((e) => VideoModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return Future.value(videoModel);
  }

  @override
  Future<List<VideoModel>> getVideoForCustomer(String customerId) async {
    QuerySnapshot snapshot = await videoReferenceForCustomer
        .doc(customerId)
        .collection('video_order')
        .get();
    // print(
    //     "object in Video remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<VideoModel> videoModel = await snapshot.docs
        .map((e) => VideoModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return Future.value(videoModel);
  }

  @override
  Future<void> updateVideo(String videoId, String customerId)async {
    return await videoReferenceForCustomer
        .doc(customerId)
        .collection('video_order')
        .doc(videoId)
        .update({"isPaid":true}).then((value) => print('ALL OK'));
    
   // final collection=videoReferenceForCustomer
   //      .doc(customerId)
   //      .collection('video_order');
   // var newDocumentBody = {"isPaid": true};
   // var response=await collection.where("video_id", isEqualTo: videoId).get();
   // print("responselar: ::::::::::::::::${response.docs.toString()}");
   // var batch=FirebaseFirestore.instance.batch();
   // response.docs.forEach((element) {
   //   var docRef=collection.doc(videoId);
   //   batch.update(docRef, newDocumentBody);
   // });
   // batch.commit().then((value) {
   //   print("Collection ichidagi hamma docs yangilandi.");
   // });

    //
    // CollectionReference collection = FirebaseFirestore.instance.collection('something');
// This collection can be a subcollection.

    // _updateAllFromCollection(CollectionReference collection) async {
    //   var newDocumentBody = {"username": ''};
    //   User firebaseUser = FirebaseAuth.instance.currentUser;
    //   DocumentReference docRef;
    //
    //   var response = await collection.where('uid', isEqualTo: firebaseUser.uid).get();
    //   var batch = FirebaseFirestore.instance.batch();
    //   response.docs.forEach((doc) {
    //     docRef = collection.doc(doc.id);
    //     batch.update(docRef, newDocumentBody);
    //   });
    //   batch.commit().then((a) {
    //     print('updated all documents inside Collection');
    //   });
    // }
    //
  }

  @override
  Future<List<VideoModel>> getDateTimeOrders(DateTime dateTime) async{
    QuerySnapshot customerQuerySnapshot = await videoReferenceForCustomer.get();

    List<VideoModel> quantityList=[];
    final allCustomerIDS = customerQuerySnapshot.docs.map((doc) {
      return doc["customerId"];
    }).toList();

    for (int i = 0; i < allCustomerIDS.length; i++) {
      print(":::: for ichida docs ids: ${allCustomerIDS[i]}");
      CollectionReference _video_Ref =
      videoReferenceForCustomer.doc(allCustomerIDS[i]).collection('video_order');

      QuerySnapshot  videoQuerySnapshot=await _video_Ref
          .where('isPaid', isEqualTo: true)
          .where('dateTimeOfWedding'.toString(), isEqualTo: dateTime.toString())
          .get();

      quantityList.addAll( videoQuerySnapshot.docs.map((doc) {
        return VideoModel.fromJson(doc.data() as Map<String, dynamic>);
      }).toList());

      print("::::quantityList: ${quantityList.toList()}");


      print(dateTime.toString());

    }

    return Future.value(quantityList) ;
  }
  }

