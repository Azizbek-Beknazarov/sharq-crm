import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sharq_crm/features/services/video/data/model/video_model.dart';

abstract class VideoRemoteDataSource {
  Future<List<VideoModel>> getVideo();

  Future<List<VideoModel>> getVideoForCustomer(String customerId);

  Future<void> addVideo(VideoModel newVideo, String customerId);

  Future<void> deleteVideo(
      {required String customerId, required String videoID});
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
    print(
        "object in Video remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
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
    print(
        "object in Video remote ds: ${snapshot.docs.map((e) => e.data()).toList()}");
    List<VideoModel> videoModel = await snapshot.docs
        .map((e) => VideoModel.fromJson(e.data() as Map<String, dynamic>))
        .toList();
    return Future.value(videoModel);
  }
}
