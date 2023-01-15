import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  String carId;
  String name;
  String carNumber;
  String color;
  String address;
  int dateTime;
  int price;

  CarEntity(
      {required this.carId,
      required this.name,
      required this.carNumber,
      required this.color,
      required this.address,
      required this.dateTime,
      required this.price});

  @override
  List<Object?> get props =>
      [carId, name, carNumber, color, address, dateTime, price];
}
