import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';
import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

import '../../features/services/video/domain/entity/video_entity.dart';
import '../error/failures.dart';

abstract class UseCase<Type, Params> {
  Future<Either<Failure, Type>> call(Params params);
}

abstract class UseCaseOne<Type, Params> {
  Future<Type> call({required Params params});
}

//Params
//1
class NoParams extends Equatable {
  @override
  List<Object> get props => [];
}

//2
class CarParams extends Equatable {
  final CarEntity carParam;

  CarParams(this.carParam);

  @override
  List<Object?> get props => [carParam];
}

//3
class CustomerUpdateParams extends Equatable {
  CustomerEntity customerEntity;
  String id;

  CustomerUpdateParams(this.customerEntity, this.id);

  @override
  List<Object?> get props => [customerEntity, id];
}

//4
class PhotoStudioParams extends Equatable {
  final PhotoStudioEntity newPhotoStudio;
  String customerId;

  PhotoStudioParams(
    this.newPhotoStudio,
    this.customerId,
  );

  @override
  List<Object?> get props => [newPhotoStudio, customerId];
}

//5
class PhotoStudioGetParams extends Equatable {
  String customerId;

  PhotoStudioGetParams({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}

//6
class CustomerFromCollectionParam {
  String customerID;

  CustomerFromCollectionParam({required this.customerID});

  @override
  List<Object?> get props => [customerID];
}

//7
class PhotoStudioDeleteParams extends Equatable {
  String customerId;
  String photoStudioID;

  PhotoStudioDeleteParams(
      {required this.customerId, required this.photoStudioID});

  @override
  List<Object?> get props => [customerId, photoStudioID];
}

//8
class ClubDeleteParams extends Equatable {
  String customerId;
  String clubID;

  ClubDeleteParams({required this.customerId, required this.clubID});

  @override
  List<Object?> get props => [customerId, clubID];
}

//9
class ClubGetParams extends Equatable {
  String customerId;

  ClubGetParams({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}

//10
class ClubParams extends Equatable {
  final ClubEntity newClub;
  String customerId;

  ClubParams(
    this.newClub,
    this.customerId,
  );

  @override
  List<Object?> get props => [newClub, customerId];
}

//11
class AlbumDeleteParams extends Equatable {
  String customerId;
  String albumID;

  AlbumDeleteParams({required this.customerId, required this.albumID});

  @override
  List<Object?> get props => [customerId, albumID];
}

//12
class AlbumGetParams extends Equatable {
  String customerId;

  AlbumGetParams({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}

//13
class AlbumParams extends Equatable {
  final AlbumEntity newAlbum;
  String customerId;

  AlbumParams(
    this.newAlbum,
    this.customerId,
  );

  @override
  List<Object?> get props => [newAlbum, customerId];
}

//14
class VideoDeleteParams extends Equatable {
  String customerId;
  String videoID;

  VideoDeleteParams({required this.customerId, required this.videoID});

  @override
  List<Object?> get props => [customerId, videoID];
}

//15
class VideoGetParams extends Equatable {
  String customerId;

  VideoGetParams({required this.customerId});

  @override
  List<Object?> get props => [customerId];
}

//16
class VideoParams extends Equatable {
  final VideoEntity newVideo;
  String customerId;

  VideoParams(
    this.newVideo,
    this.customerId,
  );

  @override
  List<Object?> get props => [newVideo, customerId];
}
//17

class VideoUpdateParams extends Equatable {

  String customerId;
  String videoId;

  VideoUpdateParams(
      this.videoId,
      this.customerId,
      );

  @override
  List<Object?> get props => [videoId, customerId];
}
//18
class PhotoStudioUpdateParams extends Equatable {

  String customerId;
  String photoStudioId;

  PhotoStudioUpdateParams(
      this.photoStudioId,
      this.customerId,
      );

  @override
  List<Object?> get props => [photoStudioId, customerId];
}
//19
class ClubUpdateParams extends Equatable {

  String customerId;
  String clubId;

  ClubUpdateParams(
      this.clubId,
      this.customerId,
      );

  @override
  List<Object?> get props => [clubId, customerId];
}
//20
class AlbumUpdateParams extends Equatable {

  String customerId;
  String albumId;

  AlbumUpdateParams(
      this.albumId,
      this.customerId,
      );

  @override
  List<Object?> get props => [albumId, customerId];
}

