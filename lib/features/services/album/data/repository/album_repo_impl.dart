import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/exception.dart';

import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/network/network_info.dart';
import 'package:sharq_crm/features/services/album/data/datasourse/album_remote_datasource.dart';
import 'package:sharq_crm/features/services/album/data/model/album_model.dart';
import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';
import 'package:sharq_crm/features/services/album/domain/repository/album_repo.dart';

class AlbumRepoImpl implements AlbumRepo {
  final AlbumRemoteDataSource remoteDS;
  NetworkInfo info;

  AlbumRepoImpl({required this.remoteDS, required this.info});

  final _convert = (AlbumEntity e) => AlbumModel(
        album_id: e.album_id,
        price: e.price,
        dateTimeOfWedding: e.dateTimeOfWedding,
        ordersNumber: e.ordersNumber,
        description: e.description,
        address: e.address,
    isPaid: e.isPaid,
    customerId: e.customerId,
    prepayment: e.prepayment,
        //
      );

  @override
  Future<void> addAlbum(AlbumEntity newAlbum, String customerId) async {
    AlbumEntity entity = AlbumEntity(
      album_id: newAlbum.album_id,
      price: newAlbum.price,
      dateTimeOfWedding: newAlbum.dateTimeOfWedding,
      ordersNumber: newAlbum.ordersNumber,
      description: newAlbum.description,
      address: newAlbum.address,
      isPaid: newAlbum.isPaid,
      customerId: newAlbum.customerId,
      prepayment: newAlbum.prepayment,
    );
    AlbumModel model = _convert(entity);
    return await remoteDS.addAlbum(model, customerId);
  }

  @override
  Future<void> deleteAlbum(String customerId, String albumID) async {
    return await remoteDS.deleteAlbum(customerId: customerId, albumID: albumID);
  }

  @override
  Future<Either<Failure, List<AlbumEntity>>> getAlbum() async {
    if (await info.isConnected) {
      try {
        final result = await remoteDS.getAlbum();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<AlbumEntity>>> getAlbumForCustomer(
      String customerId) async {
    if (await info.isConnected) {
      try {
        final result = await remoteDS.getAlbumForCustomer(customerId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> updateAlbum(String albumId, String customerId)async {
return await remoteDS.updateAlbum(albumId, customerId);
  }
}
