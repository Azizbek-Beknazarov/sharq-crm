

import '../../domain/entity/video_entity.dart';

class VideoModel extends VideoEntity {
  VideoModel({
    required String video_id,
    required int price,
    required String dateTimeOfWedding,
    required int ordersNumber,
    required String description,
    required String address
  }) : super(
    address: address,
          video_id: video_id,
          price: price,
          dateTimeOfWedding: dateTimeOfWedding,
          ordersNumber: ordersNumber,
          description: description,
        );

  factory VideoModel.fromJson(Map<String, dynamic> json) {
    return VideoModel(
      video_id: json['video_id'],
      price: json['price'],
      dateTimeOfWedding: json['dateTimeOfWedding'],
      ordersNumber: json['ordersNumber'],
      description: json['description'] ?? '',
      address: json['address'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'video_id': video_id,
      'price': price,
      'dateTimeOfWedding': dateTimeOfWedding,
      'ordersNumber': ordersNumber,
      'description': description,
      'address': address,
    };
  }
}
