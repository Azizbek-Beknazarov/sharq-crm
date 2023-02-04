import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

class PhotoStudioModel extends PhotoStudioEntity {
  PhotoStudioModel({
    required String photo_studio_id,
    required int price,
    required String dateTimeOfWedding,
    required String largeImage,
    required int ordersNumber,
    required String smallImage,
    required String description,
    required int smallPhotoNumber,
    required int largePhotosNumber,
    required bool isPaid,
  }) : super(
          photo_studio_id: photo_studio_id,
          price: price,
          dateTimeOfWedding: dateTimeOfWedding,
          largeImage: largeImage,
          ordersNumber: ordersNumber,
          smallImage: smallImage,
          description: description,
          smallPhotoNumber: smallPhotoNumber,
          largePhotosNumber: largePhotosNumber,
      isPaid:isPaid,
        );

  factory PhotoStudioModel.fromJson(Map<String, dynamic> json) {
    return PhotoStudioModel(
      photo_studio_id: json['photo_studio_id'],
      price: json['price'],
      dateTimeOfWedding: json['dateTimeOfWedding'],
      largeImage: json['largeImage'],
      ordersNumber: json['ordersNumber'],
      smallImage: json['smallImage'],
      description: json['description'] ?? '',
      smallPhotoNumber: json['smallPhotoNumber'],
      largePhotosNumber: json['largePhotosNumber'],
      isPaid: json['isPaid'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'photo_studio_id': photo_studio_id,
      'price': price,
      'dateTimeOfWedding': dateTimeOfWedding,
      'largeImage': largeImage,
      'ordersNumber': ordersNumber,
      'smallImage': smallImage,
      'description': description,
      'smallPhotoNumber': smallPhotoNumber,
      'largePhotosNumber': largePhotosNumber,
      'isPaid': isPaid,
    };
  }
}
