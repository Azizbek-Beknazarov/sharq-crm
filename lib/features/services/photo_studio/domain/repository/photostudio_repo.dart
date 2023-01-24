import 'package:dartz/dartz.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

import '../../../../../core/error/failures.dart';

abstract class PhotoStudioRepo {
  Future<Either<Failure, List<PhotoStudioEntity>>> getPhotoStudio();
  Future<Either<Failure, List<PhotoStudioEntity>>> getPhotoStudioForCustomer(String customerId);

  Future<void> addPhotoStudio(PhotoStudioEntity newPhotoStudio, String customerId);
  Future<void> deletePhotoStudio( String customerId,String photoStudioID);

}
