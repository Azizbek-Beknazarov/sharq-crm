import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/exception.dart';

import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/network/network_info.dart';
import 'package:sharq_crm/features/services/photo_studio/data/datasourse/photostudio_remote_ds.dart';
import 'package:sharq_crm/features/services/photo_studio/data/model/photostudio_model.dart';

import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

import '../../domain/repository/photostudio_repo.dart';

class PhotoStudioRepoImpl implements PhotoStudioRepo {
  final PhotoStudioRemoteDS remoteDS;
  NetworkInfo info;

  PhotoStudioRepoImpl({required this.remoteDS, required this.info});

  @override
  Future<Either<Failure, List<PhotoStudioEntity>>> getPhotoStudio() async {
    if (await info.isConnected) {
      try {
        final result = await remoteDS.getPhotoStudio();
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  final _convert = (PhotoStudioEntity e) => PhotoStudioModel(
        photo_studio_id: e.photo_studio_id,
        price: e.price,
        dateTimeOfWedding: e.dateTimeOfWedding,
        largeImage: e.largeImage,
        ordersNumber: e.ordersNumber,
        smallImage: e.smallImage,
        description: e.description,
        smallPhotoNumber: e.smallPhotoNumber,
        largePhotosNumber: e.largePhotosNumber,
        //
      );

  @override
  Future<void> addPhotoStudio(PhotoStudioEntity newPhotoStudio,String customerId) async {
    PhotoStudioEntity entity = PhotoStudioModel(
      photo_studio_id: newPhotoStudio.photo_studio_id,
      price: newPhotoStudio.price,
      dateTimeOfWedding: newPhotoStudio.dateTimeOfWedding,
      largeImage: newPhotoStudio.largeImage,
      ordersNumber: newPhotoStudio.ordersNumber,
      smallImage: newPhotoStudio.smallImage,
      description: newPhotoStudio.description,
      smallPhotoNumber: newPhotoStudio.smallPhotoNumber,
      largePhotosNumber: newPhotoStudio.largePhotosNumber,
    );
    PhotoStudioModel model = _convert(entity);
    return await remoteDS.addPhotoStudio(model,customerId);
  }

  @override
  Future<Either<Failure, List<PhotoStudioEntity>>> getPhotoStudioForCustomer(String customerId) async{
    if (await info.isConnected) {
      try {
        final result = await remoteDS.getPhotoStudioForCustomer(customerId);
        return Right(result);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<void> deletePhotoStudio(String customerId, String photoStudioID)async {

    return await remoteDS.deletePhotoStudio(customerId: customerId, photostudioID: photoStudioID);
  }
}
