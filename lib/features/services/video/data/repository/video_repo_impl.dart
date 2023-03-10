import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/exception.dart';

import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/network/network_info.dart';


import '../../domain/entity/video_entity.dart';
import '../../domain/repository/video_repo.dart';
import '../datasourse/video_remote_datasource.dart';
import '../model/video_model.dart';

class VideoRepoImpl implements VideoRepo {
  final VideoRemoteDataSource remoteDS;
  NetworkInfo info;

  VideoRepoImpl({required this.remoteDS, required this.info});

  final _convert = (VideoEntity e) => VideoModel(
        video_id: e.video_id,
        price: e.price,
        dateTimeOfWedding: e.dateTimeOfWedding,
        ordersNumber: e.ordersNumber,
        description: e.description,
        address: e.address,
      isPaid: e.isPaid,
    customerId: e.customerId,
    prepayment: e.prepayment,
    timeOfWedding: e.timeOfWedding,
        //
      );

  @override
  Future<void> addVideo(VideoEntity newVideo, String customerId) async {
    VideoEntity entity = VideoEntity(
      video_id: newVideo.video_id,
      price: newVideo.price,
      dateTimeOfWedding: newVideo.dateTimeOfWedding,
      ordersNumber: newVideo.ordersNumber,
      description: newVideo.description,
      address: newVideo.address,
        isPaid: newVideo.isPaid,
      customerId: newVideo.customerId,
      prepayment: newVideo.prepayment,
      timeOfWedding: newVideo.timeOfWedding,
    );
    VideoModel model = _convert(entity);
    return await remoteDS.addVideo(model, customerId);
  }

  @override
  Future<void> deleteVideo(String customerId, String videoID) async {
    return await remoteDS.deleteVideo(customerId: customerId, videoID: videoID);
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideo() async {
    if (await info.isConnected) {
      try {
        final result = await remoteDS.getVideo();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<VideoEntity>>> getVideoForCustomer(
      String customerId) async {
    if (await info.isConnected) {
      try {
        final result = await remoteDS.getVideoForCustomer(customerId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> updateVideo(String videoId, String customerId)async {


    return await remoteDS.updateVideo(videoId, customerId);
  }

  @override
  Future<List<VideoEntity>> getDateTimeOrders(DateTime dateTime)async {
    final result=await remoteDS.getDateTimeOrders(dateTime);
    return Future.value(result);
  }
}
