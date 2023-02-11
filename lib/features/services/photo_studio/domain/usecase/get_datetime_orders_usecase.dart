import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/repository/photostudio_repo.dart';

import '../entity/photostudio_entity.dart';

class PhotoGetDateTimeOrdersUsecase
    extends UseCaseOne<List<PhotoStudioEntity>, GetDateTimeOrdersParam> {
  final PhotoStudioRepo repo;

  PhotoGetDateTimeOrdersUsecase({required this.repo});

  @override
  Future<List<PhotoStudioEntity>> call({required GetDateTimeOrdersParam params}) async {
    return await repo.getDateTimeOrders(params.dateTime);
  }
}
