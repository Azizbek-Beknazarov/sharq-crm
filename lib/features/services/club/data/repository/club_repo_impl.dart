import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/exception.dart';

import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/network/network_info.dart';
import 'package:sharq_crm/features/services/club/data/datasourse/club_remote_datasource.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/data/datasourse/photostudio_remote_ds.dart';
import 'package:sharq_crm/features/services/photo_studio/data/model/photostudio_model.dart';

import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

import '../../domain/repository/club_repo.dart';
import '../model/club_model.dart';

class ClubRepoImpl implements ClubRepo {
  final ClubRemoteDataSource remoteDS;
  NetworkInfo info;

  ClubRepoImpl({required this.remoteDS, required this.info});

  final _convert = (ClubEntity e) => ClubModel(
        club_id: e.club_id,
        price: e.price,
        dateTimeOfWedding: e.dateTimeOfWedding,
        ordersNumber: e.ordersNumber,
        description: e.description,
        fromHour: e.fromHour,
        toHour: e.toHour,
    isPaid: e.isPaid,
    customerId: e.customerId,
    prepayment: e.prepayment,
        //
      );

  //
  @override
  Future<void> addClub(ClubEntity newClub, String customerId) async {
    ClubEntity entity = ClubEntity(
      club_id: newClub.club_id,
      price: newClub.price,
      dateTimeOfWedding: newClub.dateTimeOfWedding,
      ordersNumber: newClub.ordersNumber,
      description: newClub.description,
      fromHour: newClub.fromHour,
      toHour: newClub.toHour,
      isPaid: newClub.isPaid,
      customerId: newClub.customerId,
      prepayment: newClub.prepayment,
    );
    ClubModel model = _convert(entity);
    return await remoteDS.addClub(model, customerId);
  }

  @override
  Future<void> deleteClub(String customerId, String clubID) async {
    return await remoteDS.deleteClub(customerId: customerId, clubID: clubID);
  }

  @override
  Future<Either<Failure, List<ClubEntity>>> getClub() async {
    if (await info.isConnected) {
      try {
        final result = await remoteDS.getClub();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<ClubEntity>>> getClubForCustomer(
      String customerId) async {
    if (await info.isConnected) {
      try {
        final result = await remoteDS.getClubForCustomer(customerId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> updateClub(String clubId, String customerId) async{
    return await remoteDS.updateClub(clubId, customerId);
  }
}
