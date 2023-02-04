import 'package:equatable/equatable.dart';

class PhotoStudioEntity extends Equatable {
  String photo_studio_id;
  int price;
  String dateTimeOfWedding;
  int ordersNumber;
  int smallPhotoNumber;
  int largePhotosNumber;

  String largeImage;
  String smallImage;

  String description;
  bool isPaid;

  PhotoStudioEntity({
    required this.photo_studio_id,
    required this.price,
    required this.dateTimeOfWedding,
    required this.largeImage,
    required this.ordersNumber,
    required this.smallImage,
    required this.description,
    required this.largePhotosNumber,
    required this.smallPhotoNumber,
    required this.isPaid
  });

  @override
  List<Object?> get props => [
        photo_studio_id,
        price,
        dateTimeOfWedding,
        ordersNumber,
        largeImage,
        smallImage,
        description,
        smallPhotoNumber,
        largePhotosNumber,
    isPaid
      ];
}
