import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';

class AlbumModel extends AlbumEntity {
  AlbumModel({
    required String album_id,
    required int price,
    required String dateTimeOfWedding,
    required int ordersNumber,
    required String description,
  }) : super(
          album_id: album_id,
          price: price,
          dateTimeOfWedding: dateTimeOfWedding,
          ordersNumber: ordersNumber,
          description: description,
        );

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      album_id: json['album_id'],
      price: json['price'],
      dateTimeOfWedding: json['dateTimeOfWedding'],
      ordersNumber: json['ordersNumber'],
      description: json['description'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'album_id': album_id,
      'price': price,
      'dateTimeOfWedding': dateTimeOfWedding,
      'ordersNumber': ordersNumber,
      'description': description,
    };
  }
}
