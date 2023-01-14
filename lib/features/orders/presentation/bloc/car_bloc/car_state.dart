import 'package:equatable/equatable.dart';

import '../../../domain/entity/car_entity.dart';

abstract class CarStates extends Equatable {
  const CarStates();

  @override
  List<Object> get props => [];
}

//1
class CarInitialState extends CarStates {}

//2
class CarLoadingState extends CarStates {}

//3
class CarAddedState extends CarStates {}

//4
class CarErrorState extends CarStates {
  final String error;

  CarErrorState({required this.error});
}
//5
class CarLoadedState extends CarStates {
  final List<CarEntity> cars;
   CarLoadedState({required this.cars});
   @override
   List<Object> get props => [cars];
}
