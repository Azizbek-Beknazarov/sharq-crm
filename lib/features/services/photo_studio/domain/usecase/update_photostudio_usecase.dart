import '../../../../../core/usecase/usecase.dart';
import '../repository/photostudio_repo.dart';

class UpdatePhotoStudioUseCase extends UseCaseOne<void, PhotoStudioUpdateParams> {
  final PhotoStudioRepo repo;

  UpdatePhotoStudioUseCase({required this.repo});

  @override
  Future<void> call({required PhotoStudioUpdateParams params}) async {
    return await repo.updatePhotoStudio(
      params.photoStudioId, params.customerId,);
  }
}