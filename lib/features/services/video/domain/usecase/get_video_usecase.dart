import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';


import '../entity/video_entity.dart';
import '../repository/video_repo.dart';


class GetVideoUseCase extends UseCase<List<VideoEntity>, NoParams> {
  final VideoRepo repo;

  GetVideoUseCase({required this.repo});

  @override
  Future<Either<Failure, List<VideoEntity>>> call(NoParams params) async {
    return await repo.getVideo();
  }
}
