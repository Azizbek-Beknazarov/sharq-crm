import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';
import 'package:sharq_crm/features/services/album/domain/repository/album_repo.dart';



class AlbumGetDateTimeOrdersUsecase
    extends UseCaseOne<List<AlbumEntity>, GetDateTimeOrdersParam> {
  final AlbumRepo repo;

  AlbumGetDateTimeOrdersUsecase({required this.repo});

  @override
  Future<List<AlbumEntity>> call({required GetDateTimeOrdersParam params}) async {
    return await repo.getDateTimeOrders(params.dateTime);
  }
}
