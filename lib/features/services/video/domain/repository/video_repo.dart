import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../entity/video_entity.dart';

abstract class VideoRepo {
  Future<Either<Failure, List<VideoEntity>>> getVideo();
  Future<Either<Failure, List<VideoEntity>>> getVideoForCustomer(String customerId);

  Future<void> addVideo(VideoEntity newVideo, String customerId);
  Future<void> updateVideo(String videoId, String customerId );
  Future<void> deleteVideo( String customerId,String videoID);

}
