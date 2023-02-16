import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/club/domain/repository/club_repo.dart';

import '../../../../../core/usecase/usecase.dart';

class ClubGetDateTimeOrdersUsecase extends UseCaseOne<List<ClubEntity>, GetDateTimeOrdersParam>{
  final ClubRepo repo;
  ClubGetDateTimeOrdersUsecase({required this.repo});
  @override
  Future<List<ClubEntity>> call({required GetDateTimeOrdersParam params}) async{
   return await repo.getDateTimeOrders(params.dateTime);
  }
}