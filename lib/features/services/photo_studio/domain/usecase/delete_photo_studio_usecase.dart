import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/repository/photostudio_repo.dart';

class DeletePhotoStudioUsecase
    extends UseCaseOne<void, PhotoStudioDeleteParams> {
  final PhotoStudioRepo repo;

  DeletePhotoStudioUsecase({required this.repo});

  @override
  Future<void> call({required PhotoStudioDeleteParams params}) async {
    return await repo.deletePhotoStudio(
        params.customerId, params.photoStudioID);
  }
}
