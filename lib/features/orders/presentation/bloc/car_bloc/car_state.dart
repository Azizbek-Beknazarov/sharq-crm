import 'package:equatable/equatable.dart';

abstract class CarStates extends Equatable {
  const CarStates();

  @override
  List<Object> get props => [];
}

//1
class CarInitialState extends CarStates{}
//2
class CarLoadingState extends CarStates{}
//3
class CarLoadedState extends CarStates{}
//4
class CarErrorState extends CarStates{
  final String error;
  CarErrorState({required this.error});
}