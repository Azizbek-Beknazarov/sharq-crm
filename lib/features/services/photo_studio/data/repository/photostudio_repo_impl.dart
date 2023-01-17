import 'package:dartz/dartz.dart';
import 'package:sharq_crm/core/error/exception.dart';

import 'package:sharq_crm/core/error/failures.dart';
import 'package:sharq_crm/core/network/network_info.dart';
import 'package:sharq_crm/features/services/photo_studio/data/datasourse/photostudio_remote_ds.dart';

import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

import '../../domain/repository/photostudio_repo.dart';

class PhotoStudioRepoImpl implements PhotoStudioRepo{
  final PhotoStudioRemoteDS remoteDS;
  final NetworkInfo info;
  PhotoStudioRepoImpl({required this.remoteDS,required this.info});
  @override
  Future<Either<Failure, List<PhotoStudioEntity>>> getPhotoStudio() async{
  if(await info.isConnected){
    try{
    final result=  await remoteDS.getPhotoStudio();
      return Right(result);
    }on ServerException{
      return Left(ServerFailure());
    }
  }else {
    return Left(ServerFailure());
  }
  }
}