import 'package:equatable/equatable.dart';
import 'package:sharq_crm/features/orders/domain/entity/car_entity.dart';

abstract class CarEvents extends Equatable {
  const CarEvents([List props = const <dynamic>[]]) : super();

  @override
  List<Object> get props => [props];
}

//1
class CarAddNewEvent extends CarEvents {
  final CarEntity newCar;


  CarAddNewEvent(this.newCar, ) : super([newCar, ]);
}

//2
class CarGetAllEvent extends CarEvents {



  CarGetAllEvent();
}
