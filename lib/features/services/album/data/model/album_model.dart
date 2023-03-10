import 'package:sharq_crm/features/services/album/domain/entity/album_entity.dart';

class AlbumModel extends AlbumEntity {
  AlbumModel({
    required String album_id,
    required int price,
    required String dateTimeOfWedding,
    required String timeOfWedding,
    required int ordersNumber,
    required String description,
    required String address,
    required bool isPaid,
    required String customerId,
    required int prepayment,

  }) : super(
          album_id: album_id,
          price: price,
          dateTimeOfWedding: dateTimeOfWedding,
          ordersNumber: ordersNumber,
          description: description,
    address: address,
    isPaid: isPaid,
    customerId: customerId,
    prepayment: prepayment,
    timeOfWedding: timeOfWedding,
        );

  factory AlbumModel.fromJson(Map<String, dynamic> json) {
    return AlbumModel(
      album_id: json['album_id'],
      price: json['price'],
      dateTimeOfWedding: json['dateTimeOfWedding'],
      ordersNumber: json['ordersNumber'],
      description: json['description'] ?? '',
      address: json['address'] ?? '',
      isPaid: json['isPaid'] ?? '',
      customerId: json['customerId'] ?? '',
      prepayment: json['prepayment'] ?? '',
      timeOfWedding: json['timeOfWedding'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'album_id': album_id,
      'price': price,
      'dateTimeOfWedding': dateTimeOfWedding,
      'ordersNumber': ordersNumber,
      'description': description,
      'address': address,
      'isPaid': isPaid,
      'customerId': customerId,
      'prepayment': prepayment,
      'timeOfWedding': timeOfWedding,
    };
  }
}
