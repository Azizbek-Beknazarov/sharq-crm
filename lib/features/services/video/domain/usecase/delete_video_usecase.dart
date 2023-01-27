import 'package:sharq_crm/core/usecase/usecase.dart';

import '../repository/video_repo.dart';


class DeleteVideoClubUsecase
    extends UseCaseOne<void, VideoDeleteParams> {
  final VideoRepo repo;

  DeleteVideoClubUsecase({required this.repo});

  @override
  Future<void> call({required VideoDeleteParams params}) async {
    return await repo.deleteVideo(
        params.customerId, params.videoID);
  }
}
