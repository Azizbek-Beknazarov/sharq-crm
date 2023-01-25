import 'package:dartz/dartz.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/club/domain/repository/club_repo.dart';

import '../../../../../core/error/failures.dart';
import '../../../../../core/usecase/usecase.dart';


class GetClubForCustomerUseCase extends UseCase<List<ClubEntity>, ClubGetParams> {
  final ClubRepo repo;

  GetClubForCustomerUseCase({required this.repo});

  @override
  Future<Either<Failure, List<ClubEntity>>> call(ClubGetParams params) async {
    return await repo.getClubForCustomer(params.customerId);
  }
}