
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/club/domain/repository/club_repo.dart';

class AddClubUseCase extends UseCaseOne<void, ClubParams> {
  final ClubRepo repo;

  AddClubUseCase({required this.repo});

  @override
  Future<void> call({required ClubParams params}) async{
   return await repo.addClub(params.newClub,params.customerId);
  }




}
