import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:sharq_crm/features/customers/domain/entity/customer_entity.dart';
import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';
import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';
import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

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
  List<Object?> get props => [newPhotoStudio,customerId];
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
  List<Object?> get props => [newClub,customerId];
}
