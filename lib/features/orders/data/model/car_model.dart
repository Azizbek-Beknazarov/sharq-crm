import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';

class CarModel extends CarEntity {
  CarModel({
    required String carId,
    required String name,
  }) : super(carId: carId, name: name);

  factory CarModel.fromJson(Map<String, dynamic> json) {
    return CarModel(
      name: json['name'] ?? "",
      carId: json['carId'] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'carId': carId,
      'name': name,
    };
  }
}





