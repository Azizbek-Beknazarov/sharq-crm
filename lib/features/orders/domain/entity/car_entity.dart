import 'package:equatable/equatable.dart';

class CarEntity extends Equatable {
  String carId;
  String name;

  CarEntity({required this.carId,required this.name });

  @override
  List<Object?> get props => [carId,name];
}