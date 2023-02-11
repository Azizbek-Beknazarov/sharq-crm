import 'package:sharq_crm/core/usecase/usecase.dart';

import 'package:sharq_crm/features/services/video/domain/entity/video_entity.dart';
import 'package:sharq_crm/features/services/video/domain/repository/video_repo.dart';



class VideoGetDateTimeOrdersUsecase
    extends UseCaseOne<List<VideoEntity>, GetDateTimeOrdersParam> {
  final VideoRepo repo;

  VideoGetDateTimeOrdersUsecase({required this.repo});

  @override
  Future<List<VideoEntity>> call({required GetDateTimeOrdersParam params}) async {
    return await repo.getDateTimeOrders(params.dateTime);
  }
}
