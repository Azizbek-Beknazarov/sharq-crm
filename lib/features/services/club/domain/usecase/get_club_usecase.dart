import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/usecase/usecase.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/club/domain/repository/club_repo.dart';

class GetClubUseCase extends UseCase<List<ClubEntity>, NoParams> {
  final ClubRepo repo;

  GetClubUseCase({required this.repo});

  @override
  Future<Either<Failure, List<ClubEntity>>> call(NoParams params) async {
    return await repo.getClub();
  }
}
