import 'package:dartz/dartz.dart';


import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entity/video_entity.dart';
import '../repository/video_repo.dart';


class GetVideoForCustomerUseCase extends UseCase<List<VideoEntity>, VideoGetParams> {
  final VideoRepo repo;

  GetVideoForCustomerUseCase({required this.repo});

  @override
  Future<Either<Failure, List<VideoEntity>>> call(VideoGetParams params) async {
    return await repo.getVideoForCustomer(params.customerId);
  }
}