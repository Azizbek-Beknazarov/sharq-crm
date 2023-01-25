
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/repository/photostudio_repo.dart';

class AddPhotoStudioUseCase extends UseCaseOne<void, PhotoStudioParams> {
  final PhotoStudioRepo repo;

  AddPhotoStudioUseCase({required this.repo});

  @override
  Future<void> call({required PhotoStudioParams params}) async{
   return await repo.addPhotoStudio(params.newPhotoStudio,params.customerId);
  }




}
