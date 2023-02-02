import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/video/domain/repository/video_repo.dart';

class UpdateVideoUseCase extends UseCaseOne<void, VideoUpdateParams> {
  final VideoRepo repo;

  UpdateVideoUseCase({required this.repo});

  @override
  Future<void> call({required VideoUpdateParams params}) async {
    return await repo.updateVideo(
        params.videoId, params.customerId,);
  }
}
