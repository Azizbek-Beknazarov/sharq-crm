import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/club/domain/repository/club_repo.dart';


class DeleteClubUsecase
    extends UseCaseOne<void, ClubDeleteParams> {
  final ClubRepo repo;

  DeleteClubUsecase({required this.repo});

  @override
  Future<void> call({required ClubDeleteParams params}) async {
    return await repo.deleteClub(
        params.customerId, params.clubID);
  }
}
