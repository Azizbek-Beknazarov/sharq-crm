import 'package:sharq_crm/features/services/club/domain/entity/club_entity.dart';

class ClubModel extends ClubEntity {
  ClubModel({
    required String club_id,
    required int price,
    required String dateTimeOfWedding,
    required int ordersNumber,
    required String description,
    required int fromHour,
    required int toHour,
    required bool isPaid,
    required String customerId,
    required int prepayment,

  }) : super(
          club_id: club_id,
          price: price,
          dateTimeOfWedding: dateTimeOfWedding,
          fromHour: fromHour,
          toHour: toHour,
          ordersNumber: ordersNumber,
          description: description,
          isPaid: isPaid,
          customerId: customerId,
          prepayment: prepayment,

        );

  factory ClubModel.fromJson(Map<String, dynamic> json) {
    return ClubModel(
      club_id: json['club_id'],
      price: json['price'],
      dateTimeOfWedding: json['dateTimeOfWedding'],
      ordersNumber: json['ordersNumber'],
      description: json['description'] ?? '',
      fromHour: json['fromHour'],
      toHour: json['toHour'],
      isPaid: json['isPaid'],
      customerId: json['customerId'],
      prepayment: json['prepayment'],

    );
  }

  Map<String, dynamic> toJson() {
    return {
      'club_id': club_id,
      'price': price,
      'dateTimeOfWedding': dateTimeOfWedding,
      'toHour': toHour,
      'ordersNumber': ordersNumber,
      'fromHour': fromHour,
      'description': description,
      'isPaid': isPaid,
      'customerId': customerId,
      'prepayment': prepayment,
    };
  }
}
