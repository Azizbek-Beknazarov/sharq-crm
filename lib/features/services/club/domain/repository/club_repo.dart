import 'package:dartz/dartz.dart';

import '../../../../../core/error/failures.dart';
import '../entity/club_entity.dart';

abstract class ClubRepo {
  Future<Either<Failure, List<ClubEntity>>> getClub();
  Future<Either<Failure, List<ClubEntity>>> getClubForCustomer(String customerId);

  Future<void> addClub(ClubEntity newClub, String customerId);
  Future<void> deleteClub( String customerId,String clubID);
  Future<void> updateClub(String clubId, String customerId );
  Future<List<ClubEntity>> getDateTimeOrders(DateTime dateTime);
}
