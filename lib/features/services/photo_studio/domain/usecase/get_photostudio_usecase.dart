import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/repository/photostudio_repo.dart';

class GetPhotoStudioUseCase extends UseCase<List<PhotoStudioEntity>, NoParams> {
  final PhotoStudioRepo repo;

  GetPhotoStudioUseCase({required this.repo});

  @override
  Future<Either<Failure, List<PhotoStudioEntity>>> call(NoParams params) async {
    return await repo.getPhotoStudio();
  }
}
