import 'package:sharq_crm/features/services/photo_studio/domain/entity/photostudio_entity.dart';

class PhotoStudioModel extends PhotoStudioEntity {
  PhotoStudioModel(
      {required String photo_studio_id,
      required int price,
      required int dateTimeOfWedding,
      required int largeImage,
      required int ordersNumber,
      required int smallImage,
      required String description

      })
      : super(
          photo_studio_id: photo_studio_id,
          price: price,
          dateTimeOfWedding: dateTimeOfWedding,
          largeImage: largeImage,
          ordersNumber: ordersNumber,
          smallImage: smallImage,
          description: description,
        );

  factory PhotoStudioModel.fromJson(Map<String, dynamic> json) {
    return PhotoStudioModel(
        photo_studio_id: json['photo_studio_id']?? '',
        price: json['price']??01,
        dateTimeOfWedding: json['dateTimeOfWedding']??0,
        largeImage: json['largeImage']??0,
        ordersNumber: json['ordersNumber']??0,
        smallImage: json['smallImage']??0,
        description: json['description']?? ''

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
    };
  }
}
