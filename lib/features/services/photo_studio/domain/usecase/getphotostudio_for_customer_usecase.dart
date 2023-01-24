import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';
import '../entity/photostudio_entity.dart';
import '../repository/photostudio_repo.dart';

class GetPhotoStudioForCustomerUseCase extends UseCase<List<PhotoStudioEntity>, PhotoStudioGetParams> {
  final PhotoStudioRepo repo;

  GetPhotoStudioForCustomerUseCase({required this.repo});

  @override
  Future<Either<Failure, List<PhotoStudioEntity>>> call(PhotoStudioGetParams params) async {
    return await repo.getPhotoStudioForCustomer(params.customerId);
  }
}