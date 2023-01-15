import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';

class CarModel extends CarEntity {
  CarModel({
    required String carId,
    required String name,
    required String carNumber,
    required String color,
    required String address,
    required int dateTime,
    required int price,
  }) : super(
            carId: carId,
            name: name,
            carNumber: carNumber,
            color: color,
            address: address,
            dateTime: dateTime,
            price: price);

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      name: json['name'] ?? "",
      carId: json['carId'] ?? "",
      carNumber: json['carNumber'] ?? "",
      color: json['color'] ?? "",
      address: json['address'] ?? "",
      dateTime: json['dateTime'] ?? "",
      price: json['price'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'name': name,
      'carNumber': carNumber,
      'color': color,
      'address': address,
      'dateTime': dateTime,
      'price': price,
    };
  }
}
