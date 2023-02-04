import '../../../../../core/usecase/usecase.dart';
import '../repository/club_repo.dart';

class UpdateClubUseCase extends UseCaseOne<void, ClubUpdateParams> {
  final ClubRepo repo;

  UpdateClubUseCase({required this.repo});

  @override
  Future<void> call({required ClubUpdateParams params}) async {
    return await repo.updateClub(
      params.clubId, params.customerId,);
  }
}